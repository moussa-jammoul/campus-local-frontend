import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';

abstract class CoursePageServicesDomain {
  Future<void> createNewCourse(Course data);
  Future<void> updateCourse(Course data);
  void nullCurrentCourses();
}