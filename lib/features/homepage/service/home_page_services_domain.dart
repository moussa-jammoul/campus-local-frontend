import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';

abstract class HomePageServicesDomain {
  Future<void> logOut();
  Future<void> createNewSemester(Semester data);
  Future<void> updateSemester(Semester data);
  Future<void> refreshLinkedDevices();
  Future<void> deleteSemesterCascade(int id, String semesterUuid ,String userUid);
  
}