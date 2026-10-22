import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';

abstract class CoursePageServicesDomain {
  Future<void> createNewCourse(Course data);
  Future<void> updateCourse(Course data);
  //note that semester uuid used to re-read the data , uuid to delete cloud data , id to delete local data 
  Future<void> deleteCourse(String uuid , int id , String semesterUuid);
  void nullCurrentCourses();
}