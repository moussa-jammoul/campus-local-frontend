import 'dart:typed_data';

import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';


//TODO video service
abstract class MediaServicesDomain {
 
  ///will handle all edges , adding them the the local db , storage
  ///caching new media , cloud ...
  Future<Uint8List?> addMedia(MediaForm data);

  Future<void> updateMedia(MediaForm data);
  
  ///only deleting things locally , for more information , go to media cloud domain
  ///inside core/database/cloud/domain  ,we need uuid to also delete the thumbnail
  Future<void> deleteMedia(String uuid);
  
  ///it will handle the ui request that they are outside the render box for caching videos
  ///thumbnails
  Future<void> markInvisibleVIDEOthumbnail(String uuid);
  

  ///ui images request this function to render the image , note that addMedia
  ///also return the media , but on creation , no need to call manually thsi function
  ///after adding media
  Future<Uint8List?> returnVIDEOthumbnail(String uuid);

}