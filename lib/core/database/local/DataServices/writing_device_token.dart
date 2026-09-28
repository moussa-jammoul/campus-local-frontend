import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/db/main_db.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

class WritingDeviceToken extends Notifier<void> {
  AppDatabase? db;
  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
    db = ref.read(dbProvider);
  }

  Future<void> writeData(DeviceToken newData) async {
  if (db != null) {
    logger.i('writing device token locally: $newData');
    try {
      await db!.into(db!.deviceTokenDB).insertOnConflictUpdate(
        DeviceTokenDBCompanion.insert(
          userUid: newData.userUid,
          notifictionToken: newData.notificationToken,
          deviceAccountUniqueKey: newData.uniqueDeviceAccountId,
          deviceName: newData.deviceName,
        ),
      );
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  } else {
    throw Error();
  }
}

Future<DeviceToken?> readData(String deviceAccountUniqueKey) async {
  if (db != null) {
    logger.i('reading device token locally for device: $deviceAccountUniqueKey');
    try {
      final rawData = await (db!.select(db!.deviceTokenDB)
            ..where((t) => t.deviceAccountUniqueKey.equals(deviceAccountUniqueKey)))
          .getSingleOrNull();

      if (rawData == null) return null;

      return DeviceToken(
        userUid: rawData.userUid,
        uniqueDeviceAccountId: rawData.deviceAccountUniqueKey,
        notificationToken: rawData.notifictionToken,
        deviceName: rawData.deviceName,
        createdAt: rawData.createdAt,
        updatedAt: rawData.updatedAt,
      );
    } catch (e) {
      logger.e(e);
      return null;
    }
  } else {
    return null;
  }
}

Future<List<DeviceToken>> readAllForUser(String userUid) async {
  if (db != null) {
    logger.i('reading all device tokens locally for user: $userUid');
    try {
      final rawRows = await (db!.select(db!.deviceTokenDB)
            ..where((t) => t.userUid.equals(userUid)))
          .get();

      return rawRows
          .map((row) => DeviceToken(
                userUid: row.userUid,
                uniqueDeviceAccountId: row.deviceAccountUniqueKey,
                notificationToken: row.notifictionToken,
                deviceName: row.deviceName,
                createdAt: row.createdAt,
                updatedAt: row.updatedAt,
              ))
          .toList();
    } catch (e) {
      logger.e(e);
      return [];
    }
  } else {
    return [];
  }
}

  Future<void> updateData(DeviceToken data) async {
    if (db != null) {
      logger.i('updating device token locally: $data');
      try {
        await (db!.update(db!.deviceTokenDB)
              ..where((t) => t.deviceAccountUniqueKey.equals(data.uniqueDeviceAccountId)))
            .write(DeviceTokenDBCompanion(
              notifictionToken: Value(data.notificationToken),
              updatedAt: Value(DateTime.now()),
            ));
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      throw Error();
    }
  }

  Future<void> deleteData(String deviceAccountUniqueKey) async {
    if (db != null) {
      logger.i('deleting device token locally for device: $deviceAccountUniqueKey');
      try {
        await (db!.delete(db!.deviceTokenDB)
              ..where((t) => t.deviceAccountUniqueKey.equals(deviceAccountUniqueKey)))
            .go();
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      throw Error();
    }
  }
}

final writingDeviceTokenProvider = NotifierProvider<WritingDeviceToken, void>(() {
  return WritingDeviceToken();
});