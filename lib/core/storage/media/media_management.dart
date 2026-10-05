import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/form.dart';
import 'package:logger/web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:video_thumbnail/video_thumbnail.dart';


///relative path for any media is : user/<-userUuid->/course/<-courseUuid->/media/<-mediauuid->.fileExtention
///for video thumbnail is : thumbnail/<-mediauuid->.fileExtention



class MediaManagment extends Notifier<void> {

  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  Future<File> _resolveMediaFile(String relativePath) async{
    final appDocDir = await getApplicationDocumentsDirectory();
    return File(p.join(appDocDir.path, relativePath));
  }

  Future<SavedMediaFileInfo> saveMediaFile({
    required String sourcePath,     
    required String userUid,
    required String courseUuid,
    required String mediaUuid,     
    required String fileExtension,  
  }) async {

    try {
      final relativePath = p.join('user' , userUid,'course' , courseUuid , 'media' , '$mediaUuid.$fileExtension');

      logger.i('Saving media file: $mediaUuid.$fileExtension');

      final destinationFile = await _resolveMediaFile(relativePath);

      
      final parentDir = destinationFile.parent;
      if (!await parentDir.exists()) {
      await parentDir.create(recursive: true);
      }

      final sourceFile = File(sourcePath);
      final copiedFile = await sourceFile.copy(destinationFile.path);

      final sizeInBytes = await copiedFile.length();

      logger.i('Media file saved: $relativePath ($sizeInBytes bytes)');

      return SavedMediaFileInfo(
        relativePath: relativePath, 
        fileSizeByte: sizeInBytes, 
        fileType: fileExtension,
        );
    } catch (e, st) {
      logger.e('Failed to save media file $mediaUuid', error: e, stackTrace: st);
      rethrow;
    }

  }

  Future<void> deleteMediaFile(String relativePath) async {
    try {
      final targetFile = await _resolveMediaFile(relativePath);
      if(await targetFile.exists()){
        await targetFile.delete();
        logger.i('Media file deleted: $relativePath');
      }
    } catch (e, st) {
      logger.e('Failed to delete media file $relativePath', error: e, stackTrace: st);
      rethrow;
    }
    
  }
  

  ///used for small files , e.g images , for videos , we only need 
  ///path to handle streaming the video , also only path to handle 
  ///other files type to hand it to the OS
  Future<Uint8List?> readMediaBytes(String relativePath) async {
    try {
      final targetFile = await _resolveMediaFile(relativePath);
      if (!await targetFile.exists()) {
        logger.i('Media file not found: $relativePath');
        return null;
      }
      return await targetFile.readAsBytes();
    } catch (e, st) {
      logger.e('Failed to read media bytes $relativePath', error: e, stackTrace: st);
      rethrow;
    }
  }
  

  ///---------------video--------------------
  
  Future<SavedMediaFileInfo> saveVideoFile({
    required String sourcePath,     
    required String userUid,
    required String courseUuid,
    required String mediaUuid,     
    required String fileExtension,  
  }) async{
    try {
      final savedInfo = await saveMediaFile(
      sourcePath: sourcePath,
      userUid: userUid,
      courseUuid: courseUuid,
      mediaUuid: mediaUuid,
      fileExtension: fileExtension,
    );
    

    ///we don't want to wait thumbnail creation , or it will took long
    ///to return savedInfo
    
    unawaited(_createVideoThumbnail(savedInfo.relativePath , mediaUuid));

    return savedInfo;
    } catch (e, st) {
      logger.e('Failed to save video file $mediaUuid', error: e, stackTrace: st);
      rethrow;
    }

  }

  Future<Uint8List?> readMediaByteVideoThumbnail(String mediaUuid) async{
    try {
      final thumbFile = await _resolveThumbnailFile(mediaUuid);
      if(!await thumbFile.exists()){
        logger.i('Video thumbnail not found: $mediaUuid');
        return null;
      }

      return await thumbFile.readAsBytes();
    } catch (e, st) {
      logger.e('Failed to read video thumbnail $mediaUuid', error: e, stackTrace: st);
      rethrow;
    }
  }

  
  Future<void> _createVideoThumbnail(String relativePath , String mediaUuid) async{
    try {
      final videoFile = await _resolveMediaFile(relativePath);

      final thumbBytes = await VideoThumbnail.thumbnailData(
        video: videoFile.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );

      if (thumbBytes != null) {
        await _addVideoThumbnail(thumbBytes, mediaUuid);
        logger.i('Video thumbnail created: $mediaUuid');
      } else {
        logger.w('Video thumbnail generation returned null: $mediaUuid');
      }
    } catch (e, st) {
      // no rethrow: this runs inside unawaited(), nobody can catch it
      logger.e('Failed to create video thumbnail $mediaUuid', error: e, stackTrace: st);
    }

  }

  Future<void> _addVideoThumbnail(List<int> bytes, String mediaUuid) async{
    try {
      final thumbFile = await _resolveThumbnailFile(mediaUuid);

      final parentDir = thumbFile.parent;
      if (!await parentDir.exists()) {
        await parentDir.create(recursive: true);
      }

      await thumbFile.writeAsBytes(bytes);
    } catch (e, st) {
      logger.e('Failed to write video thumbnail $mediaUuid', error: e, stackTrace: st);
      rethrow;
    }

  }

 Future<File> _resolveThumbnailFile(String mediaUuid) async {
  final tempDir = await getApplicationSupportDirectory();
  return File(p.join(tempDir.path, 'thumbnails', '$mediaUuid.jpg'));
 }

}


final mediaManagmentProvider = NotifierProvider<MediaManagment,void>((){
  return MediaManagment();
});