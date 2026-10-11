// ignore_for_file: override_on_non_overriding_member

import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/media_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/lastSynced/last_synced_data.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services_domain.dart';

class MediaServices extends Notifier<void> implements MediaServicesDomain {

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
    return (sourcePath , await result.readAsBytes() , result.extension);
  }
}

final mediaServiceProvider = NotifierProvider<MediaServices,void>((){
  return MediaServices();
});