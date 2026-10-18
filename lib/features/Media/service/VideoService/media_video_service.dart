

import 'dart:async';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/media_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/cache/cache_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/media_management.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/VideoService/media_video_service_domain.dart';
import 'package:logger/web.dart';
import 'package:uuid/uuid.dart';

class MediaVideoService extends Notifier<void> implements MediaVideoServicesDomain {

  late Logger logger;
 
  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  @override
  Future<void> updateMedia(MediaForm data) async {
    logger.i('updating image media, uuid: ${data.uuid}');
    try {
      await ref.read(mediaProvider.notifier).updateMedia(data);

      unawaited(
        ref.read(mediaCloudProvider.notifier).updateMedia(data),
      );
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> deleteMedia(String uuid) async {
    logger.i('deleting image media, id: $uuid');
    try {
      final existing = ref.read(mediaProvider)?.firstWhereOrNull((m) => m.uuid == uuid);

      if (existing == null) {
        logger.w('media with id $uuid not found in local state, skipping file deletion');
        return;
      }

      await ref.read(mediaManagmentProvider.notifier).deleteMediaFile(existing.filepath);
      if(existing.id == null){
        logger.w("id of the media is null , meaning somehow the db failed to assign an id , skipping db delete...");
        return ;
      }
      await ref.read(mediaProvider.notifier).deleteMedia(existing.id!);
    } catch (e) {
      logger.e(e);
    }
  }


  @override
  Future<Uint8List?> returnVIDEOthumbnail(String uuid) async {
    try {
      final existing = ref.read(mediaProvider)?.firstWhereOrNull((m) => m.uuid == uuid);

      if (existing == null) {
        logger.w('media with id $uuid not found in local state, cannot render');
        return null;
      }

      return await ref.read(cacheManagmentProvider).cacheThumbnail(uuid);
    } catch (e) {
      logger.e(e);
      return null;
    }
    
  }

  
  

  @override
  Future<void> addMedia(
    {required String sourcePath, 
    required String userUid, 
    required String courseUuid,
     required String filename, 
     required String? fileDescription, 
     required String fileExtension, 
     required bool isFavorite}) async{
      logger.i('adding new video media for courseUuid: $courseUuid');
      try { 
    ///generating the uuid it outside the db , because we need it in the save media file before we insert 
    ///it to the db (we need the extra data)
    final mediaUuid = const Uuid().v7();
   
    ///quick note : the difference between saveMediaFile and saveVideoFile that save video file 
    ///have an extra step to create the video thumbnail(without waiting , so adding don't took long) , fore more details go to the media managment provider
    ///u can find it /core/storage/media/media_managment.dart
    final extraData = await ref.read(mediaManagmentProvider.notifier).saveVideoFile(
          sourcePath: sourcePath,
          userUid: userUid,
          courseUuid: courseUuid,
          mediaUuid: mediaUuid,
          fileExtension: fileExtension,
        );

    final data = MediaForm(
      uuid: mediaUuid,
      userUid: userUid,
      courseUuid: courseUuid,
      filename: filename,
      fileDescription: fileDescription,
      filepath: extraData.relativePath,
      filetype: extraData.fileType,
      filesizeByte: extraData.fileSizeByte,
      isFavorite: isFavorite,
    );

    final inserted = await ref.read(mediaProvider.notifier).addNewMedia(data);

    ///local-first architecture: we don't wait on the cloud push here,
    ///it will keep retrying until connection resolves
    unawaited(
      ref.read(mediaCloudProvider.notifier).addNewMedia(inserted),
    );
    
  } catch (e) {
    logger.e(e);
  }
   
  }

  @override
  Future<void> markInvisibleVIDEOthumbnail(String uuid) async {
    ref.read(cacheManagmentProvider).markThumbnailInvisible(uuid);
  }

  @override
  Future<String?> returnVideoExplicitePath(String relativePath) async {
    logger.e("grabing video path for the relative path : $relativePath");
    try{
    final path = await ref.read(mediaManagmentProvider.notifier).grabVideoPath(relativePath: relativePath);
    return path;
    } catch(e){
      logger.e(e);
      return null;
    }
  }

}

final mediaVideopServiceProvider = NotifierProvider<MediaVideoService, void>(() {
  return MediaVideoService();
});