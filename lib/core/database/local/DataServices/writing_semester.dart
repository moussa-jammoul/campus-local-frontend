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

  Future<Semester> writeData(Semester data) async {
  if (db != null) {
    logger.i('writing data locally: $data');
    try {
      final inserted = await db!.into(db!.semesterDB).insertReturning(
            SemesterDBCompanion.insert(
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
        final inserted = await (db!.update(db!.semesterDB)..where((t) => t.id.equals(data.id!)))
            .writeReturning(
          SemesterDBCompanion(
            semesterName: Value(data.semesterName),
            description: Value(data.description),
            finishedOrYet: Value(data.finishedOrYet),
            updatedAt: Value(DateTime.now()),
          ),
        );

        logger.i('updated semester successfully, id: ${data.id}');
        ///NOTE : we are sure that inserted is just a single updated row , because 
        ///we used the id as comparable , which is unique and primary key for this table
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