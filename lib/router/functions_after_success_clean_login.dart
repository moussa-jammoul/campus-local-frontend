import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/additional_user_data_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/addional_data_from_login.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/form.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';



bool userDataExistInTheCloud = false; // bool to check if user data exist in the cloud

Future<void> handleFirstVerifiedLogin(User user ,Logger logger, Ref ref) async {
  logger.i('running daily check up ! ');
  ///here we check if user data is missing in the cloud , missing have two reason , either user
  ///continue with google (new account) , so we show the sheet to fill the data and pushing them to 
  ///firestore  ,either error occupied while user is creating his account
  await ensureUserDataExistsInCloud(user, logger, ref);

  ///TODO , give the permision to any function that listen to firestore snapshot to start listening (fire and forgte function)
  ///TODO , checking fcm tokens current state , so it know what it should do e.g  asking user for notification access , updating fcm token
   
}



Future<void> ensureUserDataExistsInCloud(User user, Logger logger, Ref ref) async {

  while (!userDataExistInTheCloud) {
    logger.i('checking if user data exist in the backend');

    final exist = await ref.read(cloudAdditionalUserDataDB.notifier).checkUserIfExist();

    if (exist == null) {
      logger.e('failed to check, retrying after 10 seconds...');
      await Future.delayed(const Duration(seconds: 10));
      continue;
    } else if (exist == true) {
      logger.i('user data exists in the cloud!');
      userDataExistInTheCloud = true;
      //here we check if they exist locally

      await ref.read(additionalDataFromLoginProvider.notifier).readData(user.uid);
      final dataLocally = ref.read(additionalDataFromLoginProvider);
      if(dataLocally == null){
        final dataCloud = await ref.read(cloudAdditionalUserDataDB.notifier).getUserData();
        if(dataCloud == null){
          ///not really possible , we already check if the data exist in the cloud
          ///only possible if user-side error or server level error
          logger.e('unexpected: checkUserIfExist returned true but getUserData returned null');
          await Future.delayed(const Duration(seconds: 10));// retry after 10 second
        }
        else{
          await ref.read(additionalDataFromLoginProvider.notifier).addNewData(dataCloud);
          break;
        }
      } 
      else{
        break;

      }
  
     
    } else {
      logger.i('user data does not exist, checking local db...');

      await ref.read(additionalDataFromLoginProvider.notifier).readData(user.uid);
      final data = ref.read(additionalDataFromLoginProvider);

      if (data != null) {
        logger.i('user data exists locally, syncing to the cloud...');
        try {
          await ref.read(cloudAdditionalUserDataDB.notifier).createUserData(data);
          userDataExistInTheCloud = true;
        } catch (e) {
          logger.e(e);
          await Future.delayed(const Duration(seconds: 10));
        }
      } else {
        logger.i('user data does not exist locally or in the cloud, asking user to fill the form...');
        navigatorKey.currentContext?.go('/AdditionalDataSheet');
        await waitForAdditionalData(ref); // waiting for result to be at least writed locally 
        //userdataexist in the cloud will be handled in the submit logique of the page and returning to home
       
      }
    }
  }
}

//small function that help us to wait until the user plug the data required for additional data
Future<UserAdditionalData> waitForAdditionalData(Ref ref) {
  final completer = Completer<UserAdditionalData>();

  late final ProviderSubscription subscription;
  subscription = ref.listen(additionalDataFromLoginProvider, (previous, next) {
    if (next != null) {
      completer.complete(next);
      subscription.close();
    }
  });

  return completer.future;
}