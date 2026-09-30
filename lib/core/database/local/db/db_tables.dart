import 'dart:ffi';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';


/// Note on why we don't use a simple auto-increment id for tables like
/// courses, semesters, and media:
///
/// The app supports multiple devices linked to the same account. Since each
/// device writes to its own local database, we can't rely on a local
/// auto-increment counter to produce a unique id, two devices could easily
/// generate the same local id independently, causing a collision once their
/// data syncs.
///
/// Instead, each device generates a UUIDv7 for any row that needs to be
/// synced across devices. UUIDv7 embeds the creation timestamp in its
/// leading bits, so ids from different devices only risk collision if
/// generated within the same millisecond. Even then, the ~74 bits of
/// randomness left over give a real-world collision probability of about
/// 1 in 9,400,000,000,000,000,000,000, practically impossible.
///
/// If two devices edit the same row while offline, we resolve the conflict
/// with a last-write-wins strategy based on updatedAt.
///
/// The only real trade-off is storage: a UUID stored without dashes is 32
/// bytes. For 1,000 media rows, that's 1,000 * 32 = 32,000 bytes, about
/// 31 KB, negligible.
///
/// To avoid comparing long UUID strings on every local query (e.g.
/// `WHERE id = ...`), each table keeps two ids:
///  `id`: a local, auto-increment integer, used for fast local lookups,
///   joins, and foreign keys within this device's database only. It has
///   no meaning outside this device.
///  `uuid`: the UUIDv7, globally unique across all devices, used purely
///   as the identifier for syncing with the cloud and other devices (the device-to-device strategy).



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
  TextColumn get notifictionToken => text().nullable()();
  TextColumn get deviceAccountUniqueKey => text()();
  TextColumn get deviceName => text()();
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();

  @override
  Set<Column> get primaryKey => {deviceAccountUniqueKey, userUid};
}



// Semester table

class SemesterDB extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().clientDefault(() => const Uuid().v7())();

  TextColumn get userUid => text()();
  TextColumn get semesterName => text()();
  TextColumn get description => text()();
  BoolColumn get finishedOrYet => boolean()();

  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}

// Course table
@TableIndex(name: 'idx_course_semester_uuid', columns: {#semesterUuid})
class CourseDB extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().clientDefault(() => const Uuid().v7())();

  TextColumn get userUid => text()();
  TextColumn get semesterUuid => text()();
  TextColumn get courseName => text()();
  TextColumn get description => text()();
  TextColumn get professorName => text().withDefault(const Constant('doctor'))();

  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}

// Deadline table
@TableIndex(name: 'idx_deadline_media_uuid', columns: {#mediaUuid})
class DeadLineDB extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().clientDefault(() => const Uuid().v7())();

  TextColumn get userUid => text()();
  TextColumn get mediaUuid => text().nullable()();
  DateTimeColumn get dueAt => dateTime()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  BoolColumn get notified => boolean()();
}

// Media table
@TableIndex(name: 'idx_media_course_uuid', columns: {#courseUuid})
class MediaDB extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().clientDefault(() => const Uuid().v7())();

  TextColumn get userUid => text()();
  TextColumn get courseUuid => text()();

  TextColumn get fileName => text()();
  TextColumn get fileDescription => text().nullable()();
  TextColumn get filePath => text()();
  TextColumn get fileType => text()();
  IntColumn get fileSizeByte => integer()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updatedAt => dateTime().clientDefault(() => DateTime.now())();
}