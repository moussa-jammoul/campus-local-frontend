import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_semester.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';
import 'form.dart';

class SemesterProvider extends Notifier<List<Semester>?> {
  late Logger logger;

  @override
  List<Semester>? build() {
    logger = ref.read(loggerProvider);
    return null;
  }

  Future<void> readData(String userUid) async {
    logger.i('reading semesters for userUid: $userUid');
    try {
      state = await ref.read(writeSemesterProvider.notifier).readData(userUid);
      logger.i('read result: $state');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<Semester> addData(Semester data) async {
    logger.i('adding new semester: $data');
    try {
      ///here we write the data then read it from the db because created_at, updated_at, id, and uuid
      ///are init inside the data base , so writing them to the data base then reading whatever writed
      final inserted = await ref.read(writeSemesterProvider.notifier).writeData(data);
      await readData(data.userUid);
      return inserted;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> updateData(Semester data) async {
    logger.i('updating semester: $data');
    try {
      await ref.read(writeSemesterProvider.notifier).updateData(data);
      await readData(data.userUid);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> deleteData(int id, String userUid) async {
    logger.i('deleting semester, id: $id, userUid: $userUid');
    try {
      await ref.read(writeSemesterProvider.notifier).deleteData(id);
      await readData(userUid);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}

final semesterProvider = NotifierProvider<SemesterProvider, List<Semester>?>(() {
  return SemesterProvider();
});