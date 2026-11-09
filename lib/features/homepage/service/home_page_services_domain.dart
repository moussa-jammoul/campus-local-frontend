import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';

abstract class HomePageServicesDomain {
  Future<void> logOut();
  Future<void> openSecureServerConnection();
  Future<List<MediaForm>?> fetchMissedMediaLocally();
  Future<void> createNewSemester(Semester data);
  Future<void> updateSemester(Semester data);
  Future<void> refreshLinkedDevices();
  Future<void> deleteSemesterCascade(int id, String semesterUuid ,String userUid);
  
}