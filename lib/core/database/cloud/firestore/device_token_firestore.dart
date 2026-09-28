import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/device_token_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

CollectionReference<Map<String, dynamic>> get docRef => FirebaseFirestore.instance
             .collection('users')
             .doc(FirebaseAuth.instance.currentUser!.uid)
             .collection('useritems')
             .doc('devicetokens')
             .collection('devices');


DocumentReference<Map<String, dynamic>>  docRefUser(String uniqueDeviceAccountId) => FirebaseFirestore.instance
             .collection('users')
             .doc(FirebaseAuth.instance.currentUser!.uid)
             .collection('useritems')
             .doc('devicetokens')
             .collection('devices')
             .doc(uniqueDeviceAccountId);


class DeviceTokenFirestore extends Notifier<void> implements DeviceTokenCloudDomain {
 
  late Logger logger;
 

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  @override
  Future<bool?> checkUserIfExist(String uniqueDeviceAccountId) async {
    logger.i("checking if device token for the current device exist...");
    if(FirebaseAuth.instance.currentUser != null){
    try{
      final result = await docRefUser(uniqueDeviceAccountId).get();
      return result.exists;
    } catch(e){
      logger.e(e);
      return null;
    }  
    } else{
      logger.e('user uid still not initialized');
      return null;

    }
    
  }

  @override
  Future<void> createUserData(DeviceToken data) async {
    logger.i("creating device token for the current device");
    logger.i(data.toString());
     if(FirebaseAuth.instance.currentUser != null){
      try{
      await docRefUser(data.uniqueDeviceAccountId).set(
        data.toFirestore()
      );
      } catch(e){
        logger.e(e);
        rethrow;
      }

     } else{
      logger.e('user uid still not initialized');
      throw Error();
     }


    
  }

  @override
  Future<void> deleteUserData(String uniqueDeviceAccountId) async {
    logger.i('deleting user data');

    if(FirebaseAuth.instance.currentUser != null){
      try{
        await docRefUser(uniqueDeviceAccountId).delete();
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
  Future<DeviceToken?> getUserData(String uniqueDeviceAccountId) async {
    logger.i('deleting user data');

    if(FirebaseAuth.instance.currentUser != null){
      try{
        final rawResult = await docRefUser(uniqueDeviceAccountId).get();
        if (!rawResult.exists) {
        logger.i('user data does not exist in the cloud');
        return null;
        }

        return DeviceToken.fromFirestore(rawResult.data()!, uniqueDeviceAccountId: uniqueDeviceAccountId);
       
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
  Future<void> updateUserData(DeviceToken data) async {
    logger.i("updating user data");
    logger.i(data.toString());

     if(FirebaseAuth.instance.currentUser != null){
      try{
      await docRefUser(data.uniqueDeviceAccountId).update(
        data.toFirestore()
      );
      } catch(e){
        logger.e(e);
        rethrow;
      }

     } else{
      logger.e('user uid still not initialized');
      throw Error();
     }


   
  }

  @override
  Future<List<DeviceToken>?> getAllUserData(String uid) async {
    logger.i("fetching all linked account devices to the user : $uid");

     if(FirebaseAuth.instance.currentUser != null){
      try{
        final rawResult = await docRef.get();
        return rawResult.docs.map((doc){
          final singleDeviceRaw = doc.data();

          return DeviceToken.fromFirestore(singleDeviceRaw, uniqueDeviceAccountId: doc.id);
        }).toList();
      } catch(e){
        logger.e(e);
        rethrow;
      }

     } else{
      logger.e('user uid still not initialized');
      throw Error();
     }


    
    
  }

}
