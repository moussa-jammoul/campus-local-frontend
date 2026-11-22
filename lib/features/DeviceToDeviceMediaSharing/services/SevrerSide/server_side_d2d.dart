import 'dart:io';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_media.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/RequestRouter/current_process_type.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/ServerSetup/server_set_up.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/SevrerSide/media_chosen_uuid.dart';
import 'package:logger/logger.dart';


class _SendFailure implements Exception {
  _SendFailure(this.statusCode, this.message);
  final int statusCode;
  final String message;
  @override
  String toString() => message;
}

class ServerSideService extends Notifier<void>{

  
  late Logger logger;
  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  Future<void> startServerD2D() async{
    try{
    final startProcessData = await ref.read(serverSetUpProvider.notifier).startProcess();
    if(startProcessData == null){
    throw "failed to start the server";
    }
    } catch(e){
      logger.e(e);
      rethrow;
    }
}

Future<void> stopServerD2D() async{
    logger.i("stopping the server...");
    await ref.read(serverSetUpProvider.notifier).stopProcess();
}


Future<void> sendFile(HttpRequest req) async {
  var responseStarted = false; // true once we begin writing the real answer

  try{
    logger.i('_sendFile: waiting for the user to choose a file to send...');
    final uuid =await ref.read(mediaPickerManagmentfromTheAppProvider.notifier).pickMedia(
      MediaInsideTheAppPickerToSend()
    ) as String? ; 
    if(uuid == null){
      throw _SendFailure(HttpStatus.forbidden, 'user cancelled the picker');
    }
    ref.read(currentServerProcessTypeProvider.notifier).setCurrentProcessType(ProcessType.d2dDifferentAccount);
    logger.i('_sendFile: user chose media $uuid, reading the file and its data');

    final file = await ref.read(mediaProvider.notifier).returnRawFile(uuid); 
    final media = await ref.read(writeMediaProvider.notifier).findByUuid(uuid);
    logger.i('_sendFile: file found: ${file != null}, media row found: ${media != null}, available locally: ${media?.mediaExistLocally}');

    //NOTE , even if the file exist locally , but doesn't mean that we should send it
    //why ? because the file may be broken especially if the user grabbed the media from another source , but not the full file 
    //so media.mediaExistLocally is the real barrier to prevent sending a broken file , even if the ui doesn't render those files to grab them , but we loose nothing to check
    if (file == null || !await file.exists() || media == null || media.mediaExistLocally == false) {
      throw _SendFailure(HttpStatus.notFound, 'file $uuid not found or not available locally');
    }

    final length = await file.length();
    logger.i('_sendFile: file found, sending $length bytes');

    logger.i('_sendFile: setting response headers for $uuid (${media.filename}.${media.filetype}, ${media.filesizeByte} bytes in the db)');
    responseStarted = true;
    req.response
      ..statusCode = HttpStatus.ok
      ..headers.contentType = ContentType.binary
      ..headers.add('media-extension', Uri.encodeComponent(media.filetype))
      ..headers.add('media-name', Uri.encodeComponent(media.filename))
      ..headers.add('media-description', Uri.encodeComponent(media.fileDescription ?? "A Media"))
      ..contentLength = length;
    logger.i('_sendFile: headers ready, streaming the file to the receiver');
    await req.response.addStream(file.openRead());
    logger.i('_sendFile: stream finished, closing the response');
    await req.response.close();
    logger.i('_sendFile: file $uuid sent completely');

  } catch(e){
    logger.i('_sendFile: failed: $e');

    if (!responseStarted) {
      final status = e is _SendFailure ? e.statusCode : HttpStatus.internalServerError;
      try {
        req.response.statusCode = status;
        await req.response.close();
        logger.i('_sendFile: failure answer ($status) sent to the receiver');
      } catch (sendError) {
        logger.i('_sendFile: could not send the failure answer: $sendError');
      }
    } else {
      logger.i('_sendFile: failed after the response started, closing the connection');
      try {
        await req.response.close();
      } catch (_) {}
    }
  } finally{
    logger.i('_sendFile: finished, stopping the D2D server');
    await stopServerD2D();
    logger.i('_sendFile: D2D server stopped');
  }
}
 
}


final serverServicerD2DDifferentAccountProvider = NotifierProvider<ServerSideService,void>((){
  return ServerSideService();
});