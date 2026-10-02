import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/firestore/semester_firestore.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';

abstract class SemesterCloudDomain {
  Future<void> addNewSemester(Semester data);
  Future<void> deleteSemester(String uuid);
  Future<void> updateSemester(Semester data);
  Stream<QuerySnapshot<Map<String, dynamic>>>? listenToCloudUpdates();
}

final semesterCloudProvider = NotifierProvider<SemesterFirestore,void>((){
  return SemesterFirestore();
});