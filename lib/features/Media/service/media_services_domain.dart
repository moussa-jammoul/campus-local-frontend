// ignore_for_file: unused_element

import 'dart:typed_data';

import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';

abstract class MediaServicesDomain {
  ///in app opening , we run this funciton , it will decide which form
  ///of fetching data will use (e.g no data exist locally at all , or getting new updates)
  ///also use it for the refresh button inside the media ui
  Future<void> fetchCloudData({
     String? courseUuid , 
     List<String>? fileextention ,
     bool fromAVisiblePageToRenderData = true//used to check if the refresh come from a page or app startup
    });
  
  Future<(String? sourcePath , String? type)?> pickVideo(List<String> type);

  Future<(String? sourcePath , Uint8List? binary, String? type)?> pickImage(List<String> type);
  
  Future<(String? sourcePath , String? type)?> pickFile(List<String> type);
  ///only for local refresh , it read again paginated data of the very first 
  ///rows , no seperate button for it , only fetchcloud data call it 
  Future<void> refreshDataLocally(String? courseUuid , List<String>? fileextention , bool isFav);

  ///when we open a course / specific type , we should read paginated local
  ///data , we use this function to do it, the different between it and _refresh local data
  ///that refresh local data also reset the media , but read data keep loading
  ///paginated data whenever needed(in this example , whenever we reach the max scroll inside the ui
  ///we call this)
  
  Future<void> readData(String courseUuid , List<String>? fileextention);

  ///note that we prefere to put delete media in the generale media service
  ///because common in all files type and used in the same sheet used by all media
  Future<void> deleteMedia(String uuid );

  Future<void> deleteVideoThumbnail(String path );
  
}