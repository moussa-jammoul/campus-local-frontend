import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/firestore/device_token_firestore.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/form.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
abstract class DeviceTokenCloudDomain {
  Future<bool?> checkUserIfExist(String uniqueDeviceAccountId);
  Future<void> updateUserData(DeviceToken data);
  Future<void> createUserData(DeviceToken data);
  Future<void> deleteUserData(String uniqueDeviceAccountId);
  Future<DeviceToken?> getUserData(String uniqueDeviceAccountId);
  Future<List<DeviceToken>?> getAllUserData(String uid);
}

final cloudDeviceTokenDataDB = NotifierProvider<DeviceTokenFirestore,void>((){
  return DeviceTokenFirestore();
}); 