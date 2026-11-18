import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/media_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_media.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/media_management.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/data/d2d_data_layer_different_account.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/choosing_location_to_save_media_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/client_side_current_state.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/device_to_device_different_accounts_service_domain.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/headers_casting_helper.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/services/ClientSide/device_to_device_service.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v7.dart';

class DeviceToDeviceDifferentAccountService extends Notifier<void> implements DeviceToDeviceDifferentAccountsServiceDomain {

  late Logger logger;
  @override
  void build() {
    logger = ref.read(loggerProvider); 
  }




   

  @override
  QrCodePayLoadDifferentAccounts? extractDataFromQRCODE(String json) {
    try{
    logger.i('extractDataFromQRCODE: parsing scanned QR data');
    final data = QrCodePayLoadDifferentAccounts.fromJson(json: jsonDecode(json));
    logger.i('extractDataFromQRCODE: parsed, target ${data.ip}:${data.port}');
    return data;
    } catch(e){
      logger.i('extractDataFromQRCODE: failed to parse the QR data');
      logger.e(e);
      throw "Failed to Scan the Qr code, it's either wrong one , or internal error cause it";  
    }
  }

  @override
  Future<void> sendReqAndstreamReceivedDataLocally(
    {required int timeOut, 
    required String token, 
    required int port,
    required String ipAddress,
    required String expectedFingerprint,
    required SaveLocation path
    
    }) async {
        logger.i('sendReqAndstreamReceivedDataLocally: sending request to grab a media');
    try{
      
    final data = await ref.read(d2dDataLayerDifferentAccountProvider.notifier).sendRequest(
      timeOut: timeOut,
       token: token,
        port: port, 
        ipAddress: ipAddress,
         expectedFingerprint: expectedFingerprint
         );
          if(data == null) {
        logger.i('sendReqAndstreamReceivedDataLocally: no stream , request failed, skipping');
        throw "Failed to Grab a Media";
       }
       final stream = data.$1;
       final headers = data.$2;
       final headersData = MediaHeaderData.fromHeaders(headers);
       
       if(headersData == null){
        logger.i('sendReqAndstreamReceivedDataLocally: failed to cast header , stopping the process');
        throw "Failed to Grab a Media";
       }

       final userUid = FirebaseAuth.instance.currentUser?.uid;
       if(userUid == null){
        logger.i('sendReqAndstreamReceivedDataLocally:uid of the user is null');
        throw "Failed to Grab a Media";

       }
       
      

       final generatedUUID = const Uuid().v7();
       logger.e(generatedUUID);
       final mediaToBesaved = MediaForm(
        uuid: generatedUUID,
        userUid: userUid, 
        courseUuid: path.courseUuid, 
        filename:headersData.fileName ,
        fileDescription: headersData.fileDescription ,
         filepath: join('user', userUid, 'course', path.courseUuid, 'media', '$generatedUUID.${headersData.fileType}'), 
         filetype: headersData.fileType, 
         filesizeByte: headersData.fileSizeByte, 
         isFavorite: false
         );
         
         //one trade off about this model that if the user was in the process , then error happened , the media metadata will still
         //there.
         final inserted =await ref.read(writeMediaProvider.notifier).addData(mediaToBesaved, false);
         logger.e(inserted.uuid);

         //add to the cloud
         unawaited(
          ref.read(mediaCloudProvider.notifier).addNewMedia(inserted)
         );
    
        logger.i('sendReqAndstreamReceivedDataLocally: stream received, writing to disk');
        await ref.read(mediaManagmentProvider.notifier).streamBytesLocally(
        stream: stream, 
        media: inserted
        );
    } catch(e){
      rethrow;
    }

    
  }

   @override
  Future<void> startProcess({required String rawQrCodeData}) async {
    logger.i('startProcess: called');

    
    if(ref.read(clientSideCurrentStateDifferentAccountProvider) == ClientSideD2DStateDifferentAccount.running) {
      logger.i('startProcess: already running, skipping');
      return;
    }

    try{
    ref.read(clientSideCurrentStateDifferentAccountProvider.notifier).changeCurrentState(ClientSideD2DStateDifferentAccount.running);
    logger.i('startProcess: state changed to running');

    logger.i('startProcess: parsing the scanned QR code data');
    final data = extractDataFromQRCODE(rawQrCodeData);
    if(data == null) {
      logger.i('startProcess: QR code data is invalid');
      throw Error();
    }
    logger.i('startProcess: QR code parsed, target ${data.ip}:${data.port}');
    
    logger.i('startProcess: waiting for the user to choose where to save the file...');
    final pathOfTheFile = await ChoosingLocationToSaveMediaSheet.show();
    logger.i('startProcess: save location result: ${pathOfTheFile == null ? 'null' : 'a path was chosen'}');

    
    if (pathOfTheFile == null) {
      logger.i('startProcess: user cancelled the save location, stopping');
      return;//user cancelled
    }

    logger.i('startProcess: sending the request');
    await sendReqAndstreamReceivedDataLocally(
      timeOut: 10, 
      token: data.token,
      port: data.port, 
      ipAddress: data.ip, 
      expectedFingerprint: data.fingerPrint,
      path: pathOfTheFile 
      );
    logger.i('startProcess: request finished');
    } catch(e){
      logger.i('startProcess: failed');
      logger.e(e);
      rethrow;
    } finally{
      logger.i('startProcess: cleaning up, closing dio and setting the state to aborted');
      ref.read(d2dDataLayerDifferentAccountProvider.notifier).killDio();
      ref.read(clientSideCurrentStateDifferentAccountProvider.notifier).changeCurrentState(ClientSideD2DStateDifferentAccount.aborted);
      logger.i('startProcess: cleanup done');
    }
  }


}

final clientSideDifferentAccountServiceD2D = NotifierProvider<DeviceToDeviceDifferentAccountService,void>(DeviceToDeviceDifferentAccountService.new);