

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/RequestRouter/request_router_service_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/ServerSetup/server_set_up.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/ServerSetup/timer_helper.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/approvable_source.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/constantversions.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/current_server_state.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/presentation/providers/number_files_left.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/services/ServerSide/server_side_service.dart';
import 'package:logger/logger.dart';


///Request router is a service that check validity of a request , if it is authorized , and route 
///the request to a specific function if succeed the validity verifications .
///The architecure it use : 
///any request should pass by "handleRequest" which validate the request authorization, check the method
///and  the path , then route it to a sub-route inside the same class , which validate some extra information
///to that specific type of requests , then route the request to the specific service function which handle the response write 
///and the closure of the request , make sure each service should return a bool that if the process done or yet , so the sub-request 
///which server state the next step is

class RequestRouterService extends Notifier<void> implements RequestRouterServiceDomain {

  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  @override
  Future<void> handleRequest(HttpRequest req, String token) async {
  final stateNotifier = ref.read(currentServerStateProvider.notifier);

  // Not ready (starting, already processing (the local server designed to handle 1 request at a moment), stopping...)
  final current = stateNotifier.geCurrentState();
  if (current != ServerStates.waitingToScanQrCode && current != ServerStates.idle) {
    await _reply(req, HttpStatus.serviceUnavailable);
    return;
  }
  stateNotifier.changeCurrentState(ServerStates.processing);

  //every end from here , end with deciding whenever a server state should return to idle or not
  var returnToIdle = true;

  try {
    
    // first , checking if the user approved the source or not
    final approved = await ref.read(approvableSourceProvider.notifier).waitApprovment();
    if (!approved) {
      returnToIdle = false;                      
      await _reply(req, HttpStatus.forbidden);
      await ref.read(serverSetUpProvider.notifier).stopProcess();
      return;
    }

    // second , validating the Token recieved
    if (req.headers.value('x-token') != token) {
      returnToIdle = false; 
      await _reply(req, HttpStatus.unauthorized);
      await ref.read(serverSetUpProvider.notifier).stopProcess();
      return;
    }

    // third , routing
    final segments = req.uri.pathSegments;
    final sameAccount = bool.tryParse(req.uri.queryParameters['sameAccount'] ?? '');

    if (req.method == 'GET' &&
        segments.length == 2 &&
        segments[0] == 'files' &&
        sameAccount == true) {
      await _routeToSendMediaD2DsameAccount(req, segments[1]); //Note that the service close the server , no need to add extra work here
      return;
    } else if(
      req.method == 'GET' &&
      segments.length == 1 && 
      segments[0] == 'files' &&
      sameAccount == false
      ){
        await _routeToSendMediaD2DdifferentAccount(req);
        return;
    }

    // Nothing matched , malformed request
    await _reply(req, HttpStatus.badRequest);
    returnToIdle = false;
    await ref.read(serverSetUpProvider.notifier).stopProcess();

  } catch (e) {
    logger.e(e);
    await _reply(req, HttpStatus.internalServerError);
  } finally {
    if (returnToIdle) {
      final s = stateNotifier.geCurrentState();
      if (s != ServerStates.stopping && s != ServerStates.terminated) {
        stateNotifier.changeCurrentState(ServerStates.idle);
      }
    }
  }
}


Future<void> _reply(HttpRequest req, int status) async {
  try {
    req.response.statusCode = status;
    await req.response.close();
  } catch (_) {}
}
  

  Future<void> _routeToSendMediaD2DdifferentAccount(HttpRequest req) async{
    logger.i("recieved a request , to d2d different account router");
    


  }

  Future<void> _routeToSendMediaD2DsameAccount(HttpRequest req , String mediaUuid ) async{
    logger.i("received a request , to D2D router , uuif of the file : $mediaUuid");
    
    final int? nbOfFilesInt = await () async {
  final nbOfFiles = req.headers.value('x-files-number');
  if (nbOfFiles == null) {
    logger.w("d2d router : no number file detected , ending the session...");
    await _reply(req, HttpStatus.badRequest);
    return null;
  }

  final parsed = int.tryParse(nbOfFiles);
  logger.i("d2d router : number of files : $parsed");

  if (parsed == null || parsed == 0) {
    logger.w("d2d router : number of files = 0 , bad request");
    await _reply(req, HttpStatus.badRequest);
    return null;
  }

  return parsed;
  }();

    if (nbOfFilesInt == null) {
      ref.read(serverServicerD2DProvider.notifier).stopServerD2D(); //stop the server after a malformed request
      return;
    } 
    
    //calling the service side of the D2D
    await ref.read(serverServicerD2DProvider.notifier).sendFile(req, mediaUuid,nbOfFilesInt);

  }

}

final requestRouterServiceProvider = NotifierProvider<RequestRouterService,void>((){
  return RequestRouterService();
});