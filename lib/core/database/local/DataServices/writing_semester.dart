import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/db/main_db.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/web.dart';

class WritingSemester extends Notifier<void> {
  AppDatabase? db;
  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
    db = ref.read(dbProvider);
  }

  Future<List<Semester>?> readData(String userUid) async {
    if (db != null) {
      logger.i('reading semesters locally for userUid: $userUid');
      try {
         final rawRows = await (db!.select(db!.semesterDB)
                               ..where((t) => t.userUid.equals(userUid))
                               ..orderBy([
                                 (t) => OrderingTerm.desc(t.createdAt),
                               ])
                               ).get();

        final semesters = rawRows.map((rawRow) {
          final semester = Semester(
            userUid: userUid,
            semesterName: rawRow.semesterName,
            description: rawRow.description,
            finishedOrYet: rawRow.finishedOrYet,
            id: rawRow.id,
            uuid: rawRow.uuid,
            createdAt: rawRow.createdAt,
            updatedAt: rawRow.updatedAt,
          );
          return semester;
        }).toList();

        logger.i('read ${semesters.length} semesters for userUid: $userUid');
        return semesters;
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('db is null, cannot read semesters');
      return null;
    }
  }
  

  ///used to get a semester by uuid , i personally used only inside preventing echo writes for updating
  ///u may use it anywhere else
  Future<Semester?> findByUuid(String uuid) async {
  if (db == null) return null;
  final row = await (db!.select(db!.semesterDB)..where((t) => t.uuid.equals(uuid))).getSingleOrNull();
  if (row == null) return null;
  return Semester(
    id: row.id,
    uuid: row.uuid,
    userUid: row.userUid,
    semesterName: row.semesterName,
    description: row.description,
    finishedOrYet: row.finishedOrYet,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
  );
}

  Future<Semester> writeData(Semester data) async {
  if (db != null) {
    logger.i('writing data locally: $data');
    try {
      final inserted = await db!.into(db!.semesterDB).insertReturning(
            SemesterDBCompanion.insert(
              uuid:data.uuid != null ? Value(data.uuid!) : const Value.absent(),
              createdAt: data.createdAt != null ? Value(data.createdAt!) : const Value.absent(),
              updatedAt: data.updatedAt != null ? Value(data.updatedAt!) : const Value.absent(),
              userUid: data.userUid,
              semesterName: data.semesterName,
              description: data.description,
              finishedOrYet: data.finishedOrYet,
            ),
          );
      logger.i('wrote semester successfully for userUid: ${data.userUid}');
      return Semester(
        id: inserted.id,
        uuid: inserted.uuid,
        userUid: inserted.userUid,
        semesterName: inserted.semesterName,
        description: inserted.description,
        finishedOrYet: inserted.finishedOrYet,
        createdAt: inserted.createdAt,
        updatedAt: inserted.updatedAt,
      );
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  } else {
    logger.e('db is null, cannot write semester');
    throw Error();
  }
}

  Future<Semester> updateData(Semester data) async {
    if (db != null) {
      logger.i('updating semester locally: $data');
      try {
        final inserted = await (db!.update(db!.semesterDB)..where((t) => t.uuid.equals(data.uuid!)))//we used here uuid because the id is null even if we get the update from firestore , again id is local only
            .writeReturning(
          SemesterDBCompanion(
            userUid: Value(data.userUid),
            uuid: Value(data.uuid!),
            id: data.id == null ? Value.absent() : Value(data.id!) ,
            semesterName: Value(data.semesterName),
            description: Value(data.description),
            finishedOrYet: Value(data.finishedOrYet),
            createdAt: data.createdAt == null ? Value.absent(): Value(data.createdAt!),
            updatedAt: data.updatedAt == null ?  Value(DateTime.now()) : Value(data.updatedAt!),
          ),
        );

        logger.i('updated semester successfully, id: ${data.id}');
        ///NOTE : we are sure that inserted is just a single updated row , because 
        ///we used the uuid as comparable , which is unique and primary key for this table
        return Semester(
        id: inserted[0].id,
        uuid: inserted[0].uuid,
        userUid: inserted[0].userUid,
        semesterName: inserted[0].semesterName,
        description: inserted[0].description,
        finishedOrYet: inserted[0].finishedOrYet,
        createdAt: inserted[0].createdAt,
        updatedAt: inserted[0].updatedAt,
      );
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('db is null, cannot update semester');
      throw Error();
    }
  }

  Future<void> deleteData(int id) async {
    if (db != null) {
      logger.i('deleting semester locally, id: $id');
      try {
        await (db!.delete(db!.semesterDB)..where((t) => t.id.equals(id))).go();
        logger.i('deleted semester successfully, id: $id');
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('db is null, cannot delete semester');
      throw Error();
    }
  }
}

final writeSemesterProvider = NotifierProvider<WritingSemester,void>((){
  return WritingSemester();
});