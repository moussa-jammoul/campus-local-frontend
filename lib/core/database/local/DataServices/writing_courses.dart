import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/db/main_db.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

class WritingCourse extends Notifier<void> {
  AppDatabase? db;
  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
    db = ref.read(dbProvider);
  }

  Future<List<Course>?> readData(String userUid, String semesterUuid) async {
    if (db != null) {
      logger.i('reading courses locally for userUid: $userUid, semesterUuid: $semesterUuid');
      try {
        final rawRows = await (db!.select(db!.courseDB)
              ..where((t) => t.userUid.equals(userUid) & t.semesterUuid.equals(semesterUuid))
              ..orderBy([
                (t) => OrderingTerm.desc(t.createdAt),
              ]))
            .get();

        final courses = rawRows.map((rawRow) {
          final course = Course(
            id: rawRow.id,
            uuid: rawRow.uuid,
            userUid: rawRow.userUid,
            semesterUuid: rawRow.semesterUuid,
            courseName: rawRow.courseName,
            description: rawRow.description,
            professorName: rawRow.professorName,
            createdAt: rawRow.createdAt,
            updatedAt: rawRow.updatedAt,
          );
          return course;
        }).toList();

        logger.i('read ${courses.length} courses for semesterUuid: $semesterUuid');
        return courses;
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('db is null, cannot read courses');
      return null;
    }
  }

  ///used to get a course by uuid, used to prevent echo writes while listening to the cloud
  ///u may use it anywhere else
  Future<Course?> findByUuid(String uuid) async {
    if (db == null) return null;
    final row = await (db!.select(db!.courseDB)..where((t) => t.uuid.equals(uuid))).getSingleOrNull();
    if (row == null) return null;
    return Course(
      id: row.id,
      uuid: row.uuid,
      userUid: row.userUid,
      semesterUuid: row.semesterUuid,
      courseName: row.courseName,
      description: row.description,
      professorName: row.professorName,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  Future<Course> writeData(Course data) async {
    if (db != null) {
      logger.i('writing data locally: $data');
      try {
        final inserted = await db!.into(db!.courseDB).insertReturning(
              CourseDBCompanion.insert(
                uuid: data.uuid != null ? Value(data.uuid!) : const Value.absent(),
                createdAt: data.createdAt != null ? Value(data.createdAt!) : const Value.absent(),
                updatedAt: data.updatedAt != null ? Value(data.updatedAt!) : const Value.absent(),
                userUid: data.userUid,
                semesterUuid: data.semesterUuid,
                courseName: data.courseName,
                description: data.description,
                professorName:
                    data.professorName.isNotEmpty ? Value(data.professorName) : const Value.absent(),
              ),
            );
        logger.i('wrote course successfully for semesterUuid: ${data.semesterUuid}');
        return Course(
          id: inserted.id,
          uuid: inserted.uuid,
          userUid: inserted.userUid,
          semesterUuid: inserted.semesterUuid,
          courseName: inserted.courseName,
          description: inserted.description,
          professorName: inserted.professorName,
          createdAt: inserted.createdAt,
          updatedAt: inserted.updatedAt,
        );
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('db is null, cannot write course');
      throw Error();
    }
  }

  Future<Course> updateData(Course data) async {
    if (db != null) {
      logger.i('updating course locally: $data');
      try {
        final inserted = await (db!.update(db!.courseDB)..where((t) => t.uuid.equals(data.uuid!)))
            // we used uuid here because id is null even if the update came from firestore,
            // again id is local only
            .writeReturning(
          CourseDBCompanion(
            userUid: Value(data.userUid),
            uuid: Value(data.uuid!),
            semesterUuid: Value(data.semesterUuid),
            id: data.id == null ? const Value.absent() : Value(data.id!),
            courseName: Value(data.courseName),
            description: Value(data.description),
            professorName: Value(data.professorName),
            createdAt: data.createdAt == null ? const Value.absent() : Value(data.createdAt!),
            updatedAt: data.updatedAt == null ? Value(DateTime.now()) : Value(data.updatedAt!),
          ),
        );

        logger.i('updated course successfully, id: ${data.id}');
        ///NOTE: we are sure inserted is just a single updated row, because
        ///we used uuid as comparable, which is unique for this table
        return Course(
          id: inserted[0].id,
          uuid: inserted[0].uuid,
          userUid: inserted[0].userUid,
          semesterUuid: inserted[0].semesterUuid,
          courseName: inserted[0].courseName,
          description: inserted[0].description,
          professorName: inserted[0].professorName,
          createdAt: inserted[0].createdAt,
          updatedAt: inserted[0].updatedAt,
        );
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('db is null, cannot update course');
      throw Error();
    }
  }

  Future<void> deleteData(int id) async {
    if (db != null) {
      logger.i('deleting course locally, id: $id');
      try {
        await (db!.delete(db!.courseDB)..where((t) => t.id.equals(id))).go();
        logger.i('deleted course successfully, id: $id');
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('db is null, cannot delete course');
      throw Error();
    }
  }
}

final writeCourseProvider = NotifierProvider<WritingCourse, void>(() {
  return WritingCourse();
});