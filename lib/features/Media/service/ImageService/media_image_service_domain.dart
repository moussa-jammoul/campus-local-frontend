import 'dart:typed_data';

import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';

abstract class MediaImageServiceDomain {
  
  ///will handle all edges , adding them the the local db , storage
  /// cloud , state ... , no need to cache here because when the ui tile born , it
  /// call the cache
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
  

  ///it will handle the ui request that they are outside the render box for caching images
  Future<void> markInvisibleImage(int id);
  
  ///ui images request this function to render the image , note that addMedia
  ///also return the media , but on creation , no need to call manually this function
  ///after adding media , and also handle caching automatically , ui only call
  ///mark Invisible to talk to cache directly
  Future<Uint8List?> returnMediaImage(int id);

  
}