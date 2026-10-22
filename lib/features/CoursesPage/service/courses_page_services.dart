import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/courses_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/courses_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/CoursesPage/service/courses_service_domain.dart';
import 'package:logger/logger.dart';

class CoursePageServices extends Notifier<void> implements CoursePageServicesDomain {
  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  

  @override
  Future<void> createNewCourse(Course rawdata) async {
    try {
      final data = await ref.read(courseProvider.notifier).addData(rawdata);

      ///for the local-first architecture , we don't need to wait firestore function here
      ///because it will keep trying until connection resolve
      unawaited(
        ref.read(courseCloudProvider.notifier).addNewCourse(data),
      );
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> updateCourse(Course rawdata) async {
    try {
      logger.i(rawdata.toString());
      final data = await ref.read(courseProvider.notifier).updateData(rawdata);
      logger.i(data.toString());

      ///for the local-first architecture , we don't need to wait firestore function here
      ///because it will keep trying until connection resolve
      unawaited(
        ref.read(courseCloudProvider.notifier).updateCourse(data),
      );
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
  

  //used to improve ui state , explanation inside the course provider itself
  @override
  void nullCurrentCourses() {
    ref.read(courseProvider.notifier).removeCurrentState();
  }

  @override
  Future<void> deleteCourse(String uuid , int id , String semesterUuid) async{
    if(FirebaseAuth.instance.currentUser != null){
    try{
      //local
      await ref.read(courseProvider.notifier).deleteData(id, FirebaseAuth.instance.currentUser!.uid , semesterUuid);

      ///for the local-first architecture , we don't need to wait firestore function here
      ///because it will keep trying until connection resolve
      unawaited(
        ref.read(courseCloudProvider.notifier).deleteCourse(uuid),
      );

    } catch(e){
      logger.e(e);
      rethrow;
    }
    } else{
      throw Error();
    }
  }
}

final coursePageServiceProvider = NotifierProvider<CoursePageServices, void>(() {
  return CoursePageServices();
});