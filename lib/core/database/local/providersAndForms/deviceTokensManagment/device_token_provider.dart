import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_device_token.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';


///device token is the data of the user by each device , it handle data like a
///unique id for this device , notification token of the current device , and
///the user id  , with info like phone model and name  


class DeviceTokenProvider extends Notifier<DeviceToken?> {
  late Logger logger;

  @override
  DeviceToken? build() {
    logger = ref.read(loggerProvider);
    return null;
  }

  ///we handle here wiring the data to the memory and local db
  Future<void> readData(String deviceAccountUniqueKey) async {
    logger.i('reading device token locally for device: $deviceAccountUniqueKey');
    try {
      state = await ref.read(writingDeviceTokenProvider.notifier).readData(deviceAccountUniqueKey);
      logger.i('read result: $state');
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> addNewData(DeviceToken data) async {
    logger.i('writing new device token locally: $data');
    try {
      ///here we write the data then read it from the db because created_at and updated_at
      ///are init inside the data base , so writing them to the data base then reading whatever writed
      await ref.read(writingDeviceTokenProvider.notifier).writeData(data);
      await readData(data.uniqueDeviceAccountId);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> updateData(DeviceToken data) async {
    logger.i('updating device token locally: $data');
    try {
      await ref.read(writingDeviceTokenProvider.notifier).updateData(data);
      await readData(data.uniqueDeviceAccountId);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> deleteData(String deviceAccountUniqueKey) async {
    logger.i('deleting device token locally for device: $deviceAccountUniqueKey');
    try {
      state = null;
      await ref.read(writingDeviceTokenProvider.notifier).deleteData(deviceAccountUniqueKey);
    } catch (e) {
      logger.e(e);
    }
  }
}

final deviceTokenProvider = NotifierProvider<DeviceTokenProvider, DeviceToken?>(() {
  return DeviceTokenProvider();
});