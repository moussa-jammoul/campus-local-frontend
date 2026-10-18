import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:open_filex/open_filex.dart';

abstract class MediaFileServiceDomain {
   Future<void> addMedia({
  required String sourcePath,
  required String userUid,
  required String courseUuid,
  required String filename,
  required String? fileDescription,
  required String fileExtension,
  required bool isFavorite,
});

  Future<void> updateMedia(MediaForm data);
  
  ///only deleting things locally , for more information , go to media cloud domain
  ///inside core/database/cloud/domain
  Future<void> deleteMedia(int id);

  Future<OpenResult> openFileViaExternalApp(String explicitPath);
   Future<String?> grabExplicitPath(String relativePath);


}