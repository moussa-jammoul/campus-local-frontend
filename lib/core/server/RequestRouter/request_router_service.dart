

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
///and the closure of the request

class RequestRouterService extends Notifier<void> implements RequestRouterServiceDomain {

  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  @override
  Future<void> handleRequest(HttpRequest req, String token) async {
    if(ref.read(currentServerStateProvider.notifier).geCurrentState() == ServerStates.waitingToScanQrCode){
      ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.processing);
    }
    final tokenFromReq = req.headers.value('x-token');

    if(tokenFromReq == null) {
      //no token in the header , so not authorized , end the request
      req.response.statusCode = HttpStatus.nonAuthoritativeInformation;
      await req.response.close();
      ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.idle);

    }
    final method = req.method;
    final segments = req.uri.pathSegments; 
    
    //request to get a media (second segment in the path represent the file uuid)
    if(method == "GET" && segments[0] == "files" && segments.length == 2){
      _routeToSendMediaD2D(req , segments[1]);
      return;
    }  

    //if it didn't match any
    req.response.statusCode = HttpStatus.badRequest;
    await req.response.close();
  }
  

  Future<void> _routeToSendMediaD2D(HttpRequest req , String mediaUuid ) async{
    final nbOfFiles = req.headers.value('x-files-number');
    if(nbOfFiles == null){
      req.response.statusCode = HttpStatus.badRequest;
      await req.response.close();
    }
    
    //calling the service side of the D2D
    ref.read(serverServicerD2DProvider.notifier).sendFile(req, mediaUuid,int.parse(nbOfFiles!));

  }

}

final requestRouterServiceProvider = NotifierProvider<RequestRouterService,void>((){
  return RequestRouterService();
});