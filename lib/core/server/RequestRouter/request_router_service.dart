

import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/RequestRouter/request_router_service_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/current_server_state.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/providers/number_files_left.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ServerSide/server_side_service.dart';
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
     final tokenFromReq = req.headers.value('x-token');

    if(tokenFromReq == null || tokenFromReq  != token) {
      //no token in the header , so not authorized , end the request
      req.response.statusCode = HttpStatus.nonAuthoritativeInformation;
      await req.response.close();
      return ;
    }

    if(ref.read(currentServerStateProvider.notifier).geCurrentState() == ServerStates.waitingToScanQrCode || 
    ref.read(currentServerStateProvider.notifier).geCurrentState() == ServerStates.idle){
      ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.processing);
    } else{
      return;//server not ready yet , skipping the request
    }
   
    final method = req.method;
    final segments = req.uri.pathSegments; 
    
    //request to get a media (second segment in the path represent the file uuid)
    if(method == "GET" && segments[0] == "files" && segments.length == 2){
      if(!await _routeToSendMediaD2D(req , segments[1])){
      ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.idle);
      } 
      return;
    }  

    //if it didn't match any
    req.response.statusCode = HttpStatus.badRequest;
    await req.response.close();
    ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.idle);
  }
  

  Future<bool> _routeToSendMediaD2D(HttpRequest req , String mediaUuid ) async{
    logger.i("received a request , to D2D router , uuif of the file : $mediaUuid");
    final nbOfFiles = req.headers.value('x-files-number');
    if(nbOfFiles == null){
      logger.w("d2d router : no number file detected , ending the session...");
      req.response.statusCode = HttpStatus.badRequest;
      await req.response.close();
     
      return false;
    }
    int nbOfFilesInt = int.parse(nbOfFiles);
    logger.i("d2d router : number of files : $nbOfFilesInt");
    if(nbOfFilesInt == 0){
      logger.w("d2d router : number of files = 0 , bad request");
      req.response.statusCode = HttpStatus.badRequest;
      await req.response.close();
  
      return false ;
    }
    
    //calling the service side of the D2D
    return await ref.read(serverServicerD2DProvider.notifier).sendFile(req, mediaUuid,nbOfFilesInt);

  }

}

final requestRouterServiceProvider = NotifierProvider<RequestRouterService,void>((){
  return RequestRouterService();
});