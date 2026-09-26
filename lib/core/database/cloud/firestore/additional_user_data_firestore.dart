import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/additional_user_data_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

DocumentReference<Map<String, dynamic>> get userDataRef =>
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid) //using getter so if uid changed (user sign out then sign in) , userDataRef follow the new uid
        .collection('useritems')
        .doc('userdata');


class AdditionalUserDataFirestore extends Notifier<void> implements AdditionalUserDataCloudDomain {

  late Logger logger;
 

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }
  

  @override
  Future<bool?> checkUserIfExist() async {

    logger.i('checking if user data exist');

    if(FirebaseAuth.instance.currentUser != null){
    try{
    final result = await userDataRef.get();
    return result.exists;
    } catch(e){
      logger.e(e);
      return null;
    }
    }
    else{
      logger.e('user uid still not initialized');
      return null;
    }

    
  }

  @override
  Future<void> createUserData(UserAdditionalData data) async {
    logger.i('creating user data');
    logger.i('UserAdditionalData(uid: ${data.uid}, email: ${data.email}, fullname: ${data.fullname}, '
    'dateOfBirth: ${data.dateOfBirth}, role: ${data.role}, major: ${data.major}, '
    'createdAt: ${data.createdAt}, updatedAt: ${data.updatedAt})');
    if(FirebaseAuth.instance.currentUser != null){
      try{
        await userDataRef.set(data.toFirestore());
      } catch(e){
        logger.e(e);
        rethrow;
      }
    }
    else{
      logger.e('user uid still not initialized');
    }
    
  }

  @override
  Future<void> updateUserData(UserAdditionalData data) async {
    logger.i('creating user data');

    if(FirebaseAuth.instance.currentUser != null){
      try{
        await userDataRef.update(data.toFirestore());
      } catch(e){
        logger.e(e);
        rethrow;
      }
    }
    else{
      logger.e('user uid still not initialized');
    }
  }

  @override
  Future<void> deleteUserData() async {
    logger.i('deleting user data');

    if(FirebaseAuth.instance.currentUser != null){
      try{
        await userDataRef.delete(); //note that if the document doesn't exist ,  this function doesn't throw , try/catch is for any user side errors
      } catch(e){
        logger.e(e);
        rethrow;
      }
    }
    else{
      logger.e('user uid still not initialized');
    }
  }

  @override
  Future<UserAdditionalData?> getUserData() async {
  logger.i('getting user data from the cloud');

  if (FirebaseAuth.instance.currentUser != null) {
    try {
      final result = await userDataRef.get();
      if (!result.exists) {
        logger.i('user data does not exist in the cloud');
        return null;
      }
      return UserAdditionalData.fromFirestore(
        result.data()!, 
        FirebaseAuth.instance.currentUser!.uid //because we did not store firebase uid in firestore document
        );
    } catch (e) {
      logger.e(e);
      return null;
    }
  } else {
    logger.e('user uid still not initialized');
    return null;
  }
}

}