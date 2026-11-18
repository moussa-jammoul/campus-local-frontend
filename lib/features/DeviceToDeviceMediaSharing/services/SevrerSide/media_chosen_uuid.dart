import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/media_picker_sheet_from_the_app_which_return_the_uuid_of_the_media.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/pages/all_media_page.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';

//first open/closing principle practice

abstract class IMediaPickingToSend{
  Future<String?> pickMedia();
}

class MediaInsideTheAppPickerToSend extends Notifier<void> implements IMediaPickingToSend{
  @override
  void build() {
    
  }
  //we use here the global navigator key to display the media picker
  @override
  Future<String?> pickMedia() async {
    final ctx = navigatorKey.currentContext;
    if(ctx == null) return null;
    return await showModalBottomSheet<String?>(
      isScrollControlled: true,
      showDragHandle: true,

      context: ctx,
      builder: (context) => const MediaPickerSheetFromTheAppWhichReturnTheuuidOfTheMedia(),
    );
  }
}

class MediaPickerManagmentFromTheApp extends Notifier<void>{

  @override
  void build() {
  
  }

  Future<dynamic> pickMedia(IMediaPickingToSend pickerChosen) async{
    return pickerChosen.pickMedia();
  }
}


final mediaPickerManagmentfromTheAppProvider = NotifierProvider<MediaPickerManagmentFromTheApp,void>((){
  return MediaPickerManagmentFromTheApp();
});


