import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/semester_cloud_domain.dart';
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

  
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _cloudSub;

Future<void> listenToCloudUpdates() async {
  
  logger.i('sync is ready, starting to listen to cloud updates');

  Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

  while (stream == null) {
    stream = ref.read(semesterCloudProvider.notifier).listenToCloudUpdates();
    if (stream != null) break;
    logger.i('cloud stream not ready, retrying in 10s');
    await Future.delayed(const Duration(seconds: 10));
  }

  _cloudSub = stream.listen((snapshot) async {
    if (snapshot.metadata.hasPendingWrites) {
    logger.i('skipping snapshot from local pending write');
    return;
    }
    for (final change in snapshot.docChanges) {
      
      switch (change.type) {
        case DocumentChangeType.added:
          final uuid = change.doc.id;
          ///to understand why we need find by uuid and checking if it already exist , we have two
          ///cases , first guard for echo write ,when i by my self add new semester , i want to prevent firestore
          ///to push for me again the writed data , +firestore return in opening every existed document , which
          ///rewrite everything if we don't have this guard , so duplicated data
          final local = await ref.read(writeSemesterProvider.notifier).findByUuid(uuid);
          if(local == null){

          final semester = Semester.fromFirestore(change.doc.data()!, uuid);
          await addData(semester);
          } else{
            logger.i("not new data for uuid : $uuid , skipping...");
            continue;

          }

        case DocumentChangeType.modified:
          final uuid = change.doc.id;
          final incoming = Semester.fromFirestore(change.doc.data()!, uuid);

          final local = await ref.read(writeSemesterProvider.notifier).findByUuid(uuid);

          if (local != null && local.hasSameContentAs(incoming)) {
          logger.i('incoming data identical to local, skipping write, uuid: $uuid');
          continue;
          }

        if (local == null) {
          await addData(incoming);
        } else {
          await updateData(incoming);
        }

        case DocumentChangeType.removed:
          // TODO: handle delete logic when delete logic exists
      }
    }
  });

  ref.onDispose(() {
    _cloudSub?.cancel();
    logger.i('cloud subscription cancelled on dispose');
  });
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

  Future<Semester> updateData(Semester data) async {
    logger.i('updating semester: $data');
    try {
      final inserted = await ref.read(writeSemesterProvider.notifier).updateData(data);
      await readData(data.userUid);
      return inserted;
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