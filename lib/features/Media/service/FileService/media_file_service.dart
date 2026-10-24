import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/media_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/media_management.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/favorite_filter.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/FileService/media_file_service_domain.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/FilterService/filter_media_services.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';
import 'package:logger/logger.dart';
import 'package:open_filex/open_filex.dart';
import 'package:uuid/uuid.dart';

class MediaFileService extends Notifier<void> implements MediaFileServiceDomain {

  late Logger logger;
  

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  @override
  Future<void> addMedia(
    {required String sourcePath, 
    required String userUid, 
    required String courseUuid, 
    required String filename, 
    required String? fileDescription, 
    required String fileExtension, 
    required bool isFavorite
    })async {
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

    final inserted = await ref.read(mediaProvider.notifier).addNewMedia(data , false);
    await ref.read(mediaServiceProvider.notifier).refreshDataLocally(courseUuid, mediaFileFormats , false);
    ///local-first architecture: we don't wait on the cloud push here,
    ///it will keep retrying until connection resolves
    unawaited(
      ref.read(mediaCloudProvider.notifier).addNewMedia(inserted),
    );
  }catch(e){
    logger.e(e);
  }


  }


  @override
  Future<OpenResult> openFileViaExternalApp(String explicitPath) async {
    final result = await OpenFilex.open(explicitPath);
    return result;
  }

  @override
  Future<String?> grabExplicitPath(String relativePath) async{
    final path = await ref.read(mediaManagmentProvider.notifier).grabFilePath(relativePath: relativePath);
    return path;
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


}

final mediaFileServiceProvider = NotifierProvider<MediaFileService,void>((){
  return MediaFileService();
});