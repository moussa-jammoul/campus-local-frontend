import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/courses_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_courses.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

class CourseProvider extends Notifier<List<Course>?> {
  late Logger logger;

  @override
  List<Course>? build() {
    logger = ref.read(loggerProvider);
    return null;
  }
  


  ///this function used to improve ui state , how ? , when we exist from a course
  ///we call this function to make the current state null,  so if the user open another 
  ///semester , it doesn't flash on the page the current courses until the provider read the local db ,
  ///but showing th eloading spinner instead
  void removeCurrentState(){
    state = null;
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _cloudSub;

  ///NOTE: courses live in a flat, top-level collection per user (users/{uid}/courses/{courseId}),
  ///not scoped to a semester, so this listener is global and should be started once per
  ///sign-in (same place/pattern as semester's listener), not per CoursesPage visit.
  Future<void> listenToCloudUpdates() async {
    logger.i('sync is ready, starting to listen to cloud updates');

    Stream<QuerySnapshot<Map<String, dynamic>>>? stream;

    while (stream == null) {
      stream = ref.read(courseCloudProvider.notifier).listenToCloudUpdates();
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
            ///cases , first guard for echo write ,when i by my self add new course , i want to prevent firestore
            ///to push for me again the writed data , +firestore return in opening every existed document , which
            ///rewrite everything if we don't have this guard , so duplicated data
            final local = await ref.read(writeCourseProvider.notifier).findByUuid(uuid);
            if (local == null) {
              final course = Course.fromFirestore(change.doc.data()!, uuid);
              await addData(course);
            } else {
              logger.i('not new data for uuid : $uuid , skipping...');
              continue;
            }

          case DocumentChangeType.modified:
            final uuid = change.doc.id;
            final incoming = Course.fromFirestore(change.doc.data()!, uuid);

            final local = await ref.read(writeCourseProvider.notifier).findByUuid(uuid);

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

  Future<void> readData(String userUid, String semesterUuid) async {
    logger.i('reading courses for userUid: $userUid, semesterUuid: $semesterUuid');
    try {
      state = await ref.read(writeCourseProvider.notifier).readData(userUid, semesterUuid);
      logger.i('read result: $state');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<Course> addData(Course data) async {
    logger.i('adding new course: $data');
    try {
      ///here we write the data then read it from the db because created_at, updated_at, id, and uuid
      ///are init inside the data base , so writing them to the data base then reading whatever writed
      final inserted = await ref.read(writeCourseProvider.notifier).writeData(data);
      await readData(data.userUid, data.semesterUuid);

      return inserted;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<Course> updateData(Course data) async {
    logger.i('updating course: $data');
    try {
      final inserted = await ref.read(writeCourseProvider.notifier).updateData(data);
      await readData(data.userUid, data.semesterUuid);
      return inserted;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> deleteData(int id, String userUid, String semesterUuid) async {
    logger.i('deleting course, id: $id, userUid: $userUid');
    try {
      await ref.read(writeCourseProvider.notifier).deleteData(id);
      await readData(userUid, semesterUuid);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}

final courseProvider = NotifierProvider<CourseProvider, List<Course>?>(() {
  return CourseProvider();
});