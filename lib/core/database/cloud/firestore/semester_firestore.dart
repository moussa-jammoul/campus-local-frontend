import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/semester_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';
import 'dart:async';

CollectionReference<Map<String, dynamic>> get docRef =>
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid) //using getter so if uid changed (user sign out then sign in) , docRef follow the new uid
        .collection('semesters');

class SemesterFirestore extends Notifier<void> implements SemesterCloudDomain {
  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  @override
  Future<void> addNewSemester(Semester data) async {
    logger.i('adding new semester to firestore: $data');

    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await docRef.doc(data.uuid).set(data.toFirestore());
        logger.i('added semester to firestore successfully, uuid: ${data.uuid}');
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('user uid still not initialized');
    }
  }

  @override
  Future<void> deleteSemester(String uuid) async {
    logger.i('deleting semester from firestore, uuid: $uuid');

    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await docRef.doc(uuid).delete(); //note that if the document doesn't exist , this function doesn't throw , try/catch is for any user side errors
        logger.i('deleted semester from firestore successfully, uuid: $uuid');
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('user uid still not initialized');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? listenToCloudUpdates(){
    if(FirebaseAuth.instance.currentUser != null){
      logger.i("returning stream for semester cloud db ");
    return docRef.snapshots();
    } else{
      logger.e('user uid still not initialized');
     return null;
    }
  }

  @override
  Future<void> updateSemester(Semester data) async {
    logger.i('updating semester in firestore: $data');

    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await docRef.doc(data.uuid).update(data.toFirestore());
        logger.i('updated semester in firestore successfully, uuid: ${data.uuid}');
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('user uid still not initialized');
    }
  }
}