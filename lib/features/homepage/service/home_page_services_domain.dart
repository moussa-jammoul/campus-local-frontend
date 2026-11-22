import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
abstract class HomePageServicesDomain {
  Future<void> logOut();
  Future<void> openSecureServerConnection();
  Future<List<MediaForm>?> fetchMissedMediaLocally();
  Future<void> createNewSemester(Semester data);
  Future<void> updateSemester(Semester data);
  Future<void> refreshLinkedDevices();
  Future<void> deleteSemesterCascade(int id, String semesterUuid ,String userUid);
  
  
}