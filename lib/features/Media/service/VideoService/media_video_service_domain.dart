// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'dart:typed_data';

import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';



abstract class MediaVideoServicesDomain {

  
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
  
  
  
  ///it will handle the ui request that they are outside the render box for caching videos
  ///thumbnails
  Future<void> markInvisibleVIDEOthumbnail(String uuid);
  

  ///ui images request this function to render the image , when ui tile born
  ///we use this to get back the bytes of the thumbnail , it also cache the image of the thumbnail
  ///same way of images media service
  Future<Uint8List?> returnVIDEOthumbnail(String uuid);

  Future<String?> returnVideoExplicitePath(String relativePath);

}