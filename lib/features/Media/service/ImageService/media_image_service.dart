// ignore_for_file: body_might_complete_normally_nullable

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/media_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/cache/cache_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/media_management.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/favorite_filter.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/FilterService/filter_media_services.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/ImageService/media_image_service_domain.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';
import 'package:logger/web.dart';
import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';


class MediaImageService extends Notifier<void> implements MediaImageServiceDomain {
  late Logger logger;
  final allowedImage = ['png' , 'jpg'];

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  @override
Future<void> addMedia({
  required String sourcePath,
  required String userUid,
  required String courseUuid,
  required String filename,
  required String? fileDescription,
  required String fileExtension,
  required bool isFavorite,
}) async {
  logger.i('adding new image media for courseUuid: $courseUuid');
  try { 

    ///here we just handle some state stuff , like remove the filters to the state 
    ref.read(filterServicesProvider.notifier).resetFilters();
    ///generating the uuid it outside the db , because we need it in the save media file before we insert 
    ///it to the db (we need the extra data)
    



    final mediaUuid = const Uuid().v7();

    final extraData = await ref.read(mediaManagmentProvider.notifier).saveMediaFile(
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
     
     //refreshing state
    await ref.read(mediaServiceProvider.notifier).refreshDataLocally(courseUuid, allowedImage , false);


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
  Future<void> markInvisibleImage(int id) async {
    ref.read(cacheManagmentProvider).markInvisible(id);
  }

  @override
  Future<Uint8List?> returnMediaImage(int id) async {
    try {
      final existing = ref.read(mediaProvider)?.firstWhereOrNull((m) => m.id == id);

      if (existing == null) {
        logger.w('media with id $id not found in local state, cannot render');
        return null;
      }

      return await ref.read(cacheManagmentProvider).cacheImage(id, existing.filepath);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}

final mediaImageServiceProvider = NotifierProvider<MediaImageService, void>(() {
  return MediaImageService();
});