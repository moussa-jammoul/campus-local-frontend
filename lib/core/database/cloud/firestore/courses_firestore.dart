import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/courses_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

CollectionReference<Map<String, dynamic>> get courseDocRef =>
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid) //using getter so if uid changed (user sign out then sign in) , courseDocRef follow the new uid
        .collection('courses');

class CourseFirestore extends Notifier<void> implements CourseCloudDomain {
  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  @override
  Future<void> addNewCourse(Course data) async {
    logger.i('adding new course to firestore: $data');

    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await courseDocRef.doc(data.uuid).set(data.toFirestore());
        logger.i('added course to firestore successfully, uuid: ${data.uuid}');
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('user uid still not initialized');
    }
  }

  @override
  Future<void> deleteCourse(String uuid) async {
    logger.i('deleting course from firestore, uuid: $uuid');

    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await courseDocRef.doc(uuid).delete(); //note that if the document doesn't exist , this function doesn't throw , try/catch is for any user side errors
        logger.i('deleted course from firestore successfully, uuid: $uuid');
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('user uid still not initialized');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? listenToCloudUpdates() {
    if (FirebaseAuth.instance.currentUser != null) {
      logger.i('returning stream for course cloud db');
      return courseDocRef.snapshots();
    } else {
      logger.e('user uid still not initialized');
      return null;
    }
  }

  @override
  Future<void> updateCourse(Course data) async {
    logger.i('updating course in firestore: $data');

    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await courseDocRef.doc(data.uuid).update(data.toFirestore());
        logger.i('updated course in firestore successfully, uuid: ${data.uuid}');
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('user uid still not initialized');
    }
  }
}