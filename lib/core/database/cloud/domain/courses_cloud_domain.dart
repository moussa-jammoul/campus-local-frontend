import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/firestore/courses_firestore.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';

abstract class CourseCloudDomain {
  Future<void> addNewCourse(Course data);
  Future<void> deleteCourse(String uuid);
  Future<void> updateCourse(Course data);
  Stream<QuerySnapshot<Map<String, dynamic>>>? listenToCloudUpdates();
}

final courseCloudProvider = NotifierProvider<CourseFirestore, void>(() {
  return CourseFirestore();
});