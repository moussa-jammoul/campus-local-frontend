import 'dart:ffi';

import 'package:drift/drift.dart';

//Additional User data Table

class AdditionalUserDataDB extends Table{

  TextColumn get uid => text()();
  TextColumn get email => text()();
  TextColumn get fullname => text()();
  TextColumn get dateOfBirth => text()();
  TextColumn get role => text()();
  TextColumn get major => text()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {uid};
}

//Device token table

class DeviceTokenDB extends Table {
  TextColumn get userUid => text()();
  TextColumn get notifictionToken => text()();
  TextColumn get deviceAccountUniqueKey => text()();
  TextColumn get deviceName => text()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {deviceAccountUniqueKey};
}