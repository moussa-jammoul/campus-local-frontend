import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_device_token.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

class AllDevicesTokenProvider extends Notifier<List<DeviceToken>?> {
  late Logger logger;
  @override
  List<DeviceToken>? build() {
    logger = ref.read(loggerProvider);
    return null;
  }

  Future<void> loadAllDevices() async{
    if(FirebaseAuth.instance.currentUser != null){
    state = await ref.read(writingDeviceTokenProvider.notifier).readAllForUser(FirebaseAuth.instance.currentUser!.uid);
    } else{
      logger.e("user uid yet not initialized");
      throw Error();
    }
  }

}