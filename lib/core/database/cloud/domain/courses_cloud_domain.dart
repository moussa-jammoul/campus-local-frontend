import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/firestore/courses_firestore.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
abstract class CourseCloudDomain {
  Future<void> addNewCourse(Course data);
  Future<void> deleteCourse(String uuid);
  Future<void> updateCourse(Course data);
  Stream<QuerySnapshot<Map<String, dynamic>>>? listenToCloudUpdates();
}

final courseCloudProvider = NotifierProvider<CourseFirestore, void>(() {
  return CourseFirestore();
});