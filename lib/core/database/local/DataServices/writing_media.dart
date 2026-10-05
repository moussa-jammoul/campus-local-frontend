import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/db/main_db.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

class WritingMedia extends Notifier<void> {
  AppDatabase? db;
  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
    db = ref.read(dbProvider);
  }

  ///reads media metadata for a course, paginated.
  ///[limit] is how many rows to fetch this call (e.g. 50).
  ///[alreadyRead] is how many rows have already been fetched before this call,
  ///used as the offset, so the next call picks up right after the last one
  ///(e.g. first call: alreadyRead = 0, limit = 50 -> rows 1-50;
  ///second call: alreadyRead = 50, limit = 50 -> rows 51-100).
  Future<List<MediaForm>?> readData(
    String userUid,
    String courseUuid,
    int limit,
    int alreadyRead,
  ) async {
    if (db != null) {
      logger.i(
        'reading media locally for userUid: $userUid, courseUuid: $courseUuid, limit: $limit, offset: $alreadyRead',
      );
      try {
        final rawRows = await (db!.select(db!.mediaDB)
              ..where((t) => t.userUid.equals(userUid) & t.courseUuid.equals(courseUuid))
              ..orderBy([
                (t) => OrderingTerm.desc(t.createdAt),
              ])
              ..limit(limit, offset: alreadyRead))
            .get();

        final media = rawRows.map((rawRow) {
          final item = MediaForm(
            id: rawRow.id,
            uuid: rawRow.uuid,
            userUid: rawRow.userUid,
            courseUuid: rawRow.courseUuid,
            filename: rawRow.fileName,
            fileDescription: rawRow.fileDescription,
            filepath: rawRow.filePath,
            filetype: rawRow.fileType,
            filesizeByte: rawRow.fileSizeByte,
            isFavorite: rawRow.isFavorite,
            createdAt: rawRow.createdAt,
            updatedAt: rawRow.updatedAt,
          );
          return item;
        }).toList();

        logger.i('read ${media.length} media items for courseUuid: $courseUuid');
        return media;
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('db is null, cannot read media');
      return null;
    }
  }

  
  Future<MediaForm?> findByUuid(String uuid) async {
    if (db == null) return null;
    final row = await (db!.select(db!.mediaDB)..where((t) => t.uuid.equals(uuid))).getSingleOrNull();
    if (row == null) return null;
    return MediaForm(
      id: row.id,
      uuid: row.uuid,
      userUid: row.userUid,
      courseUuid: row.courseUuid,
      filename: row.fileName,
      fileDescription: row.fileDescription,
      filepath: row.filePath,
      filetype: row.fileType,
      filesizeByte: row.fileSizeByte,
      isFavorite: row.isFavorite,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  Future<MediaForm> addData(MediaForm data) async {
    if (db != null) {
      logger.i('writing data locally: $data');
      try {
        final inserted = await db!.into(db!.mediaDB).insertReturning(
              MediaDBCompanion.insert(
                uuid: data.uuid != null ? Value(data.uuid!) : const Value.absent(),
                createdAt: data.createdAt != null ? Value(data.createdAt!) : const Value.absent(),
                updatedAt: data.updatedAt != null ? Value(data.updatedAt!) : const Value.absent(),
                userUid: data.userUid,
                courseUuid: data.courseUuid,
                fileName: data.filename,
                fileDescription: Value(data.fileDescription),
                filePath: data.filepath,
                fileType: data.filetype,
                fileSizeByte: data.filesizeByte,
                isFavorite: Value(data.isFavorite),
              ),
            );
        logger.i('wrote media successfully for courseUuid: ${data.courseUuid}');
        return MediaForm(
          id: inserted.id,
          uuid: inserted.uuid,
          userUid: inserted.userUid,
          courseUuid: inserted.courseUuid,
          filename: inserted.fileName,
          fileDescription: inserted.fileDescription,
          filepath: inserted.filePath,
          filetype: inserted.fileType,
          filesizeByte: inserted.fileSizeByte,
          isFavorite: inserted.isFavorite,
          createdAt: inserted.createdAt,
          updatedAt: inserted.updatedAt,
        );
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('db is null, cannot write media');
      throw Error();
    }
  }

  Future<MediaForm> updateData(MediaForm data) async {
    if (db != null) {
      logger.i('updating media locally: $data');
      try {
        final inserted = await (db!.update(db!.mediaDB)..where((t) => t.uuid.equals(data.uuid!)))
            //we used uuid here because id is null even if we get the update from firestore,
            //again id is local only
            .writeReturning(
          MediaDBCompanion(
            userUid: Value(data.userUid),
            uuid: Value(data.uuid!),
            id: data.id == null ? const Value.absent() : Value(data.id!),
            courseUuid: Value(data.courseUuid),
            fileName: Value(data.filename),
            fileDescription: Value(data.fileDescription),
            filePath: Value(data.filepath),
            fileType: Value(data.filetype),
            fileSizeByte: Value(data.filesizeByte),
            isFavorite: Value(data.isFavorite),
            createdAt: data.createdAt == null ? const Value.absent() : Value(data.createdAt!),
            updatedAt: data.updatedAt == null ? Value(DateTime.now()) : Value(data.updatedAt!),
          ),
        );

        logger.i('updated media successfully, id: ${data.id}');
        ///NOTE: we are sure inserted is just a single updated row, because
        ///we used uuid as comparable, which is unique for this table
        return MediaForm(
          id: inserted[0].id,
          uuid: inserted[0].uuid,
          userUid: inserted[0].userUid,
          courseUuid: inserted[0].courseUuid,
          filename: inserted[0].fileName,
          fileDescription: inserted[0].fileDescription,
          filepath: inserted[0].filePath,
          filetype: inserted[0].fileType,
          filesizeByte: inserted[0].fileSizeByte,
          isFavorite: inserted[0].isFavorite,
          createdAt: inserted[0].createdAt,
          updatedAt: inserted[0].updatedAt,
        );
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('db is null, cannot update media');
      throw Error();
    }
  }

  Future<void> deleteData(int id) async {
    if (db != null) {
      logger.i('deleting media locally, id: $id');
      try {
        await (db!.delete(db!.mediaDB)..where((t) => t.id.equals(id))).go();
        logger.i('deleted media successfully, id: $id');
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('db is null, cannot delete media');
      throw Error();
    }
  }
}

final writeMediaProvider = NotifierProvider<WritingMedia, void>(() {
  return WritingMedia();
});