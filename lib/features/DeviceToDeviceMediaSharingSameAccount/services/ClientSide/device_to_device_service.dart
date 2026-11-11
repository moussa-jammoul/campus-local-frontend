import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_media.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/media_management.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/data/d2d_data_layer.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/presentation/providers/number_files_recieved.dart';

import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/services/ClientSide/client_side_current_state.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/services/ClientSide/device_to_device_service_domain.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/services/ClientSide/form.dart';
import 'package:logger/logger.dart';

class DeviceToDeviceService extends Notifier<void> implements DeviceToDeviceServiceDomain {

  late Logger logger;
  

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }


  @override
  Future<List<MediaForm>?> fetchAllUnvailableMediaLocally() async{
    logger.i('fetchAllUnvailableMediaLocally: looking for media missing locally');
    if(FirebaseAuth.instance.currentUser == null) return null;
    final mediaFound = await ref.read(writeMediaProvider.notifier).returnAllUnvailableMedia(FirebaseAuth.instance.currentUser!.uid);
    if(mediaFound == null || mediaFound.isEmpty){
      logger.i('fetchAllUnvailableMediaLocally: nothing missing, all media exist locally');
      return null;
    }

    logger.i('fetchAllUnvailableMediaLocally: ${mediaFound.length} media missing locally');
    return mediaFound;
  }

  

  @override
  Future<void> startProcess({
    required List<MediaForm> mediaThatDoesntExistLocally,
    required String rawQrCodeData,
    }) async {
      
    try{
      if(ref.read(clientSideCurrentStateProvider) == ClientSideD2DState.running) return;
      
      ref.read(clientSideCurrentStateProvider.notifier).changeCurrentState(ClientSideD2DState.running);
      final qrCodeData = extractDataFromQRCODE(rawQrCodeData);
      if(qrCodeData == null) throw Error();


      // NOTE: this is only a small check that the media belongs to the same account,
// not a real security barrier. Suppose someone bypasses it, learns a media uuid
// that belongs to another user, and that user has opened the secure connection:
// whoever scans the QR code could then fetch the media. The real protection is
// the warning shown to the user who opened the connection as soon as the first
// request arrives, saying that someone scanned the QR code. They can abort the
// process, or continue if the scan was theirs.
    if(qrCodeData.accountUid != mediaThatDoesntExistLocally.first.userUid) throw Error(); 

    logger.i('startProcess: starting, ${mediaThatDoesntExistLocally.length} files to request from ${qrCodeData.ip}:${qrCodeData.port}');
    ref.read(filesRecievedProvider.notifier).setTotal(mediaThatDoesntExistLocally.length);
    for(final media in mediaThatDoesntExistLocally){
      

      //this is how we stop process if the user abort before the next request , aborting the process
      //while streaming bytes is processed inside media_management while streaming the bytes locally 
      if(ref.read(clientSideCurrentStateProvider) == ClientSideD2DState.aborted){
        break;
      }


      logger.i('startProcess: requesting media ${media.uuid} (${media.filename}.${media.filetype})');
      await sendReqAndstreamReceivedDataLocally(
        mediaInfo: media, 
        timeOut: 20, //20 second for connection timeout 
        token: qrCodeData.token,
         nbOfFiles: mediaThatDoesntExistLocally.length, 
         port: qrCodeData.port, 
         ipAddress: qrCodeData.ip,
          expectedFingerprint: qrCodeData.fingerPrint
      );
      ref.read(filesRecievedProvider.notifier).increment();
    }
    logger.i('startProcess: all requests dispatched');
    } catch(e){
      logger.e(e);
      rethrow;
    } finally{
      ref.read(filesRecievedProvider.notifier).reset();
      ref.read(d2dDataLayerProvider.notifier).killDio();
      ref.read(clientSideCurrentStateProvider.notifier).changeCurrentState(ClientSideD2DState.aborted);
    }
    
   
  }


  @override
  QrCodePayLoad? extractDataFromQRCODE(String json) {
    try{
    logger.i('extractDataFromQRCODE: parsing scanned QR data');
    final data = QrCodePayLoad.fromJson(json: jsonDecode(json));
    logger.i('extractDataFromQRCODE: parsed, target ${data.ip}:${data.port}');
    return data;
    } catch(e){
      logger.i('extractDataFromQRCODE: failed to parse the QR data');
      logger.e(e);
      throw "Failed to Scan the Qr code, it's either wrong one , or internal error cause it";  
    }
  }

  @override
  Future<void> sendReqAndstreamReceivedDataLocally({
    required MediaForm mediaInfo,
    required int timeOut,
    required String token,
    required int nbOfFiles,
    required int port,
    required String ipAddress,
    required String expectedFingerprint,

  }) async {
    logger.i('sendReqAndstreamReceivedDataLocally: sending request for ${mediaInfo.uuid}');
    try{
    final stream = await ref.read(d2dDataLayerProvider.notifier).sendRequest(
      fileUuid: mediaInfo.uuid!, 
      timeOut: timeOut, 
      token: token, 
      nbOfFiles: nbOfFiles, 
      port: port, 
      ipAddress: ipAddress,
       expectedFingerprint: expectedFingerprint
       );

       if(stream == null) {
        logger.i('sendReqAndstreamReceivedDataLocally: no stream for ${mediaInfo.uuid}, request failed, skipping');
        return ; //we won't care about it , just return , so let's say a single req failed , it shouldn't interrupt other requests.
       }
       //one trade off about it that if the fail is repetetive , and the user have lots of files requesting , user should wait until all of them fails
       //(note that not every error is skipped , some errors like failed to reach the endpoint(if by example the user aborted the server) close the whole process)
       logger.i('sendReqAndstreamReceivedDataLocally: stream received for ${mediaInfo.uuid}, writing to disk');
       await ref.read(mediaManagmentProvider.notifier).streamBytesLocally(
        stream: stream, 
        media: mediaInfo
        );
       logger.i('sendReqAndstreamReceivedDataLocally: write started for ${mediaInfo.uuid}');
    } catch(e){
      rethrow;
    }
   
  }

}

final devicetodeviceServiceClientSideProvider = NotifierProvider<DeviceToDeviceService,void>((){
  return DeviceToDeviceService();
});