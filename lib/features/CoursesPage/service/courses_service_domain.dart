import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.

abstract class CoursePageServicesDomain {
  Future<void> createNewCourse(Course data);
  Future<void> updateCourse(Course data);
  //note that semester uuid used to re-read the data , uuid to delete cloud data , id to delete local data 
  Future<void> deleteCourse(String uuid , int id , String semesterUuid);
  void nullCurrentCourses();
}