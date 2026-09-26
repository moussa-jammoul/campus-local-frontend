import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/firestore/additional_user_data_firestore.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/form.dart';



/// Notes on how the Firestore SDK helps us with the local-first feature of this project.
///
/// Firestore write operations (.set, .update, .delete) and read operations (.get) all
/// work even when the network is unavailable , they're queued locally and automatically
/// synced once connectivity returns. Firestore also maintains a local cache of the last
/// synced data, so reads can be served from that cache while offline.
///
/// Using .snapshots() (listeners) is especially useful here: if there's no network, it
/// returns the last cached data instead of failing. Once the device comes back online,
/// Firestore automatically syncs any changes in both directions , e.g from the device to the
/// database, and from the database back down to the device.

//this abstract domain is the general rules for any cloud service db
abstract class AdditionalUserDataCloudDomain {
  Future<bool?> checkUserIfExist();
  Future<void> updateUserData(UserAdditionalData data);
  Future<void> createUserData(UserAdditionalData data);
  Future<void> deleteUserData();
  Future<UserAdditionalData?> getUserData();
}


//when u need to change the current db provider (e.g from firestore here to custom backend and db) ,  change the provider here
final cloudAdditionalUserDataDB = NotifierProvider<AdditionalUserDataFirestore,void>((){
  return AdditionalUserDataFirestore();
}); 