// ignore_for_file: override_on_non_overriding_member

import 'dart:async';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/media_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/media_management.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/lastSynced/last_synced_data.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services_domain.dart';

class MediaServices extends Notifier<void> implements MediaServicesDomain {
  final allowedFormatVideo = ['mp4', 'mov', 'mkv', 'avi'];
  final allowedFormatImage = ['jpg' , 'png'];
  final allowedFileFormat = ['pdf', 'doc', 'docx', 'ppt', 'pptx', 'xls', 'xlsx', 'txt', 'zip'];

  @override
  void build() {
    
  }
  
  
  
  
  @override
  Future<void> fetchCloudData(String? courseUuid , List<String>? fileextention) async {
  if (FirebaseAuth.instance.currentUser == null) {
    return;
  }

  List<MediaForm>? data;

  final syncInformation = ref.read(lastsyncedDataProvider);

  if (syncInformation == null) {
    ///no local sync info yet, this is a brand new device/account, pull everything
    data = await ref.read(mediaCloudProvider.notifier).fetchAllMedia();
  } else {
    ///already have some data locally, only pull what's missing since last sync
    data = await ref.read(mediaCloudProvider.notifier).syncMedia(
          syncInformation.lastUuidSynced,
          syncInformation.lastUpdateSynced,
        );
  }

  if (data == null) {
    return;
  }

  ///TODO : if data have some media their , we should notifiy the user with an overlay
  ///to bring them from the device where the data exist , yet this notification is only
  ///for notifying , device-to-device media sending still not exist in the current time 

  await ref.read(mediaProvider.notifier).addListOfMedia(data);

  ///if courseUuid != null, it mean this was called from the refresh button for a specific course
  ///if == null, this was called at app startup, no need to reload a course's paginated view
  ///no need to wait it , because we will use a sync... ui for the previous steps
  ///here it is just a local refresh
  unawaited(refreshDataLocally(courseUuid , fileextention));
  
}

  @override
  Future<void> refreshDataLocally(String? courseUuid , List<String>? fileextention) async {
    if (courseUuid != null) {
    ref.read(mediaProvider.notifier).resetMediaState();
    await ref.read(mediaProvider.notifier).loadPaginatedMediaForACourse(
          FirebaseAuth.instance.currentUser!.uid,
          courseUuid,
          70,
          fileextention
        );
  }
    
  }

  @override
  Future<void> readData(String courseUuid, List<String>? fileextention) async {
    await ref.read(mediaProvider.notifier).loadPaginatedMediaForACourse(
          FirebaseAuth.instance.currentUser!.uid,
          courseUuid,
          50,
          fileextention
        );
  }

  ///we pick the image via this function , and we return the source path to
  ///the caller so we call add media to the target type
  @override
  Future<(String? sourcePath , Uint8List? binary , String? type)?> pickImage(List<String> extentions) async {
    final result = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: extentions
    );

    if(result == null){
      return null;
    }
    final sourcePath  = result.path;
    return (sourcePath , await result.readAsBytes() , result.extension?.toLowerCase());
  }
  


  ///note about video types , if a video file type is not supported via the
  ///video player we will use in the app , we will hand the source path to the os app picker 
  ///so the user choose a certain app to open the video with 
  @override
  Future<(String? sourcePath , String? type)?> pickVideo(List<String> type) async {
    final result = await FilePicker.pickFile(
    type: FileType.custom,
    allowedExtensions: type,
  );

  if (result == null) return null;   
  return (result.path, result.extension?.toLowerCase());
    
  }
  

  ///similar to video , but we prefere to split them for readable code and understandable one
  @override
  Future<(String? sourcePath, String? type)?> pickFile(List<String> type) async {
    final result = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: type,
    );
    if(result == null) return null;
    return (result.path , result.extension?.toLowerCase());
  
  }
   

  
  @override
  Future<void> deleteMedia(String uuid ) async {
   
    try {
      //local
      final existing = ref.read(mediaProvider)?.firstWhereOrNull((m) => m.uuid == uuid);

      if (existing == null) {
        
        return;
      }
      await ref.read(mediaProvider.notifier).deleteMedia(existing.id!);
      await ref.read(mediaManagmentProvider.notifier).deleteMediaFile(existing.filepath);
      

      ///replacing the deleted one with a media , why we need it ? because when a user keep deleting a lot of
      ///media , remember we load paginated data when a user hit the scroll max ,when the user delete specific number
      ///of media ,we will never hit this max and stuck without the able to scroll
      await ref.read(mediaProvider.notifier).loadPaginatedMediaForACourse(
        existing.userUid,
        existing.courseUuid,
        1,//loading one
        _returnRelatedMedia(existing.filetype)
      );

      //cloud
      unawaited(
         ref.read(mediaCloudProvider.notifier).deleteMedia(uuid)
      );
      
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<void> deleteVideoThumbnail(String path) async {
    try{
      await ref.read(mediaManagmentProvider.notifier).deleteMediaFile(path);
    } catch(e){
      throw Error();
    }
    
  }
  

  //small helper so we return related type of media , used inside delete to load
  //a media with the same related type
  List<String> _returnRelatedMedia(String type){
    if(allowedFileFormat.contains(type)){
      return allowedFileFormat;
    }
    else if(allowedFormatVideo.contains(type)){
      return allowedFormatVideo;
    }
    else{
      return allowedFormatImage;
    }

  }
}

final mediaServiceProvider = NotifierProvider<MediaServices,void>((){
  return MediaServices();
});