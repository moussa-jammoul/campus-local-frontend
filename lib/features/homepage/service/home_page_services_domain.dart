import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';

abstract class HomePageServicesDomain {
  Future<void> logOut();
  Future<void> createNewSemester(Semester data);
  Future<void> refreshLinkedDevices();
}