import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/additional_user_data_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/device_token_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_device_token.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/all_devices_token_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/device_token_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/addional_data_from_login.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/form.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';
import 'package:device_info_plus/device_info_plus.dart';



///to make things simpler to understand for developers , we require to read this message
///any provider  that live inside /core/database/local/providersAndforms , when we call via this provider
///.addData , it will write the data in the local db then automaticaly read from that db , no need to call manually .readData (e.g device token provider , user additional data provider)
///.readData always read from the local db , never from the cloud (local - first app) , so whenever we need to read something from the cloud 
///we should get manually the data from the cloud , then .addData to the provider



bool userDataExistInTheCloudAndLocally = false; // bool to check if user data exist in the cloud

Future<void> handleFirstVerifiedLogin(User user ,Logger logger, Ref ref) async {
  logger.i('running daily check up !');
  ///here we check if user data is missing in the cloud , missing have two reason , either user
  ///continue with google (new account) , so we show the sheet to fill the data and pushing them to 
  ///firestore  ,either error occupied while user is creating his account
  await ensureUserDataExists(user, logger, ref);

  ///here we check if the current device token exist in the cloud and locally , and we call listen to fcm changes directly after we ensure 
  ///that the data exist in both cloud and locally so no race between those two logique could happen "they should be async" , same pattern of the previous one
  ///but fire-and-forget 
  unawaited(ensureDeviceTokenExistsAndListenTofcmChanges(user, logger, ref));
  

  ///loading devices linked to the account from the cloud and writing them locally
  ///this is just at the startup of the app (if network not available it read the local cached data)
  ///and also in the refresh linked devices  , if nothing found in the local cache that mean we never before called this function
  ///which require the user manually clicking refresh when network is available
  final devices = await ref.read(cloudDeviceTokenDataDB.notifier).getAllUserData(FirebaseAuth.instance.currentUser!.uid);

  if (devices != null) {
    ///same pattern we discused at the top , .add for a provider write stuff locally then automaticaly read from the db
    ref.read(allDevicesTokenProvider.notifier).addAllDevices(devices);
  }
  


  ///TODO , give the permision to any function that listen to firestore snapshot to start listening (fire and forgte function)
  
   
}



///function to listen to fcm token changes , whenever tokens change , we
///update them locally and in the cloud
Future<void> listenToFcmTokensChanges(User user, Logger logger, Ref ref) async{
   FirebaseMessaging.instance.onTokenRefresh.listen((newtoken) async{
    logger.i("User fcm token changes Fired , updating token locally and in the cloud..");
    DeviceToken? device = ref.read(deviceTokenProvider); 
    if(device != null){
      device = device.copyWith(notificationToken: newtoken);
      await ref.read(cloudDeviceTokenDataDB.notifier).updateUserData(device);
      await ref.read(deviceTokenProvider.notifier).updateData(device);
    } else{
      logger.e("user token still not initialized");
    }
  });
}


///function to ensure user current device tokens exist in the cloud and locally , and ready to listen to
///fcm tokens changes (because fcm token exist in the device token category) , devices tokens are important
///to render for the user existing linked devices to the current account , it is simply the indentifier
///of a certain device the current account hold
Future<void> ensureDeviceTokenExistsAndListenTofcmChanges(User user, Logger logger, Ref ref) async {
  bool deviceTokenExistInTheCloudAndLocally = false;
  int notificationPermissionRetryCount = 0;
  const maxNotificationPermissionRetries = 3;

  while (!deviceTokenExistInTheCloudAndLocally) {
    logger.i("checking if device token exists in the backend");
    final deviceIdentity = await resolveDeviceIdentity();

    final exist = await ref.read(cloudDeviceTokenDataDB.notifier).checkUserIfExist(deviceIdentity.deviceId);

    if (exist == null) {
      logger.e('failed to check, retrying after 10 seconds...');
      await Future.delayed(const Duration(seconds: 10));
      continue;
    } else if (exist == true) {
      logger.i('device token exists in the cloud!');

      await ref.read(deviceTokenProvider.notifier).readData(deviceIdentity.deviceId);
      final dataLocally = ref.read(deviceTokenProvider);

      if (dataLocally == null) {
        final dataCloud = await ref.read(cloudDeviceTokenDataDB.notifier).getUserData(deviceIdentity.deviceId);
        if (dataCloud == null) {
          logger.e('unexpected: checkUserIfExist returned true but getDeviceToken returned null');
          await Future.delayed(const Duration(seconds: 10));
        } else {
          await ref.read(deviceTokenProvider.notifier).addNewData(dataCloud);
          deviceTokenExistInTheCloudAndLocally = true;
          break;
        }
      } else {
        deviceTokenExistInTheCloudAndLocally = true;
        break;
      }
    } else {
      logger.i('device token does not exist, checking local db...');

      await ref.read(deviceTokenProvider.notifier).readData(deviceIdentity.deviceId);
      final data = ref.read(deviceTokenProvider);

      if (data != null) {
        logger.i('device token exists locally, syncing to the cloud...');
        try {
          await ref.read(cloudDeviceTokenDataDB.notifier).createUserData(data);
          deviceTokenExistInTheCloudAndLocally = true;
        } catch (e) {
          logger.e(e);
          await Future.delayed(const Duration(seconds: 10));
        }
      } else {
  logger.i('device token does not exist locally or in the cloud, requesting permission...');

  String? fcmToken;

  if (Platform.isWindows) {
    logger.i('Windows does not support FCM, registering device with no notification token');
    fcmToken = null;
  } else {
    fcmToken = await requestNotificationPermissionAndGetToken(logger);

    if (fcmToken == null) {
      notificationPermissionRetryCount++;
      logger.e('notification permission denied or token unavailable, attempt $notificationPermissionRetryCount of $maxNotificationPermissionRetries');

      if (notificationPermissionRetryCount < maxNotificationPermissionRetries) {
        await Future.delayed(const Duration(seconds: 10));
        continue;
      }

      logger.e('max notification permission retries reached, registering device with no token');
    }
  }

  try {
    final newDeviceToken = DeviceToken(
      userUid: user.uid,
      uniqueDeviceAccountId: deviceIdentity.deviceId,
      notificationToken: fcmToken,
      deviceName: deviceIdentity.deviceName,
    );

    await ref.read(deviceTokenProvider.notifier).addNewData(newDeviceToken);
    final deviceToken = ref.read(deviceTokenProvider);
    await ref.read(cloudDeviceTokenDataDB.notifier).createUserData(deviceToken!);
    deviceTokenExistInTheCloudAndLocally = true;
  } catch (e) {
    logger.e(e);
    await Future.delayed(const Duration(seconds: 10));
  }
}
    }
  }

  ///we plug this right here because we need it asynchronized with the previous one , or we have small
  ///chance it run before we ensure device token exist on both cloud and locally
  unawaited(listenToFcmTokensChanges(user, logger, ref));
}


///small helper function so we ask the user notification permission 
Future<String?> requestNotificationPermissionAndGetToken(Logger logger) async {
  if(!Platform.isWindows){ ///note that window does not support firebase messaging (also linux)
  final settings = await FirebaseMessaging.instance.requestPermission();

  logger.i('notification permission status: ${settings.authorizationStatus}');

  if (settings.authorizationStatus == AuthorizationStatus.denied) {
    logger.i('user denied notification permission');
    return null;
  }

  // authorized, provisional, or notDetermined (treated as proceed-and-let-getToken decide)
  final token = await FirebaseMessaging.instance.getToken();
  return token;
  } else{
    return null;
  }
}


///Small helper function to get device-specific information.
///Returns the device name (a mix of manufacturer and model, important for
///rendering to the user which device type/name each entry represents)
///and the device id (see notes below).
///
///The device id varies depending on the platform, and understanding its
///lifecycle is the most important part of how "devices" are defined here.
///
///For Android, this id survives app reinstall, install, OS update, and app
///update, as long as the app is signed with the same build key. It changes
///when the user factory resets their phone, or when the app is built with
///a different signing key.
///
///For Windows, the behavior is the same as Android, except it changes when
///the OS itself is reinstalled, rather than depending on a signing key.
///
///For macOS, the id is tied to the physical machine itself, and rarely
///changes except in specific hardware or system resets.
Future<({String deviceId, String deviceName , DeviceInfoPlugin info})> resolveDeviceIdentity() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final info = await deviceInfo.androidInfo;
    return (deviceId: info.id, deviceName: '${info.manufacturer} ${info.model}' , info: deviceInfo);
  } else if (Platform.isWindows) {
    final info = await deviceInfo.windowsInfo;
    return (deviceId: info.deviceId, deviceName: info.computerName, info: deviceInfo);
  } else if (Platform.isMacOS) {
    final info = await deviceInfo.macOsInfo;
    return (deviceId: info.systemGUID ?? 'unknown-mac-device', deviceName: info.computerName, info: deviceInfo);
  }

  ///note that this application doesn't support yet IOS build , because the project will be published
  ///in github , ios refuse any external download to their app store , if want to build custom one for
  ///ios , make sure you implement here ios case

  return (deviceId: 'unknown-device', deviceName: 'Unknown device', info: deviceInfo);
}




Future<void> ensureUserDataExists(User user, Logger logger, Ref ref) async {

  while (!userDataExistInTheCloudAndLocally) {
    logger.i('checking if user data exist in the backend');

    final exist = await ref.read(cloudAdditionalUserDataDB.notifier).checkUserIfExist();

    if (exist == null) {
      logger.e('failed to check, retrying after 10 seconds...');
      await Future.delayed(const Duration(seconds: 10));
      continue;
    } else if (exist == true) {
      logger.i('user data exists in the cloud!');
     
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
          userDataExistInTheCloudAndLocally = true;
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
          userDataExistInTheCloudAndLocally = true;
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