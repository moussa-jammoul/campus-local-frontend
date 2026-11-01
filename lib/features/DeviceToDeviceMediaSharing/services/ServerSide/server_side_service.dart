// ignore_for_file: unused_field


import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/ServerSetup/server_set_up.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/providers/number_files_left.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/providers/qrcode.dart';
import 'package:logger/logger.dart';


//TODO test the work 
//curl -k "https://IPV4:PORT/files/UUID" -H "x-token: TOKEN" -H "x-files-number: N" -o "%USERPROFILE%\Downloads\test.jpg"

class ServerSideService extends Notifier<void>{

  
  late Logger logger;
  @override
  void build() {
    logger = ref.read(loggerProvider);
  }




Future<void> startServerD2D() async{
  final startProcessData = await ref.read(serverSetUpProvider.notifier).startProcess();
  if(startProcessData == null){
    throw Error();
  }

  final qrcodeDataJson = startProcessData.jsonQRcodeData;
  if(qrcodeDataJson == null){
    throw Error();
  }
  ref.read(qrCodeDataProvider.notifier).addData(qrcodeDataJson);
}

Future<void> stopServerD2D() async{
    
    ref.read(filesLeftProvider.notifier).reset();  
    ref.read(qrCodeDataProvider.notifier).clear();
    await ref.read(serverSetUpProvider.notifier).startProcess();
}


Future<void> sendFile(HttpRequest req, String uuid , int nbOfFiles) async {

  

  //init the nb of files if it isn't initialized
  if(ref.read(filesLeftProvider.notifier).getMax() == null){
    ref.read(filesLeftProvider.notifier).setTotal(nbOfFiles);
  }
  //auto - close the server
  if(ref.read(filesLeftProvider) == 0){
    await stopServerD2D();
  }

  try{

  logger.i('_sendFile: looking for file $uuid');
  final file = await ref.read(mediaProvider.notifier).returnRawFile(uuid); 
  if (file == null || !await file.exists()) {
    logger.i('_sendFile: file $uuid not found, answering 404');
    req.response.statusCode = HttpStatus.notFound;
    await req.response.close();
    return;
  }

  final length = await file.length();
  logger.i('_sendFile: file found, sending $length bytes');
  req.response
    ..statusCode = HttpStatus.ok
    ..headers.contentType = ContentType.binary
    ..contentLength = await file.length();
  await req.response.addStream(file.openRead());
  await req.response.close();
  logger.i('_sendFile: file $uuid sent completely');
  } catch(e){
    logger.i(e);
    return;
  } finally{
    ref.read(filesLeftProvider.notifier).decrement();
  }
}
 
}


final serverServicerD2DProvider = NotifierProvider<ServerSideService,void>((){
  return ServerSideService();
});