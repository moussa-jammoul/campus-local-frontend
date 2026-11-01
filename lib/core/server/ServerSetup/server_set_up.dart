import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/device_token_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/Indentity/identity_generation_service.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/RequestRouter/request_router_service.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/ServerSetup/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/ServerSetup/server_set_up_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/ServerSetup/timer_helper.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/constantversions.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/current_server_state.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/mdns/multicast_dns_service.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/qrCode/qrcode_service.dart';
import 'package:logger/logger.dart';


///HOW to use this service ? if u are building a feature that require to start a server process ,
///some points should be clear , your job is to call start process in a certain service (which handle the multi cast dns , 
///qr code generation , identity generation ,request route..) , grab its returned value
///and use them , and use stop process to stop the server , but you should also clear the leftover inside the service
///you are building  (e.g clearing the qr code data)  , + you should add in "request_router_service" a new member function
///so it route the request to the specific function that live in your service


class ServerSetUp extends Notifier<void> implements ServerSetUpDomain {

  late Logger logger;
  HttpServer? _server;

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }

  @override
  Future<int?> bindAndOpenHTTPSCONNECTION({required GeneratedIdentity identity, required String token}) async {
    try{
    logger.i('bindAndOpenHTTPSCONNECTION: starting, building security context');
    final context = SecurityContext()
    ..useCertificateChainBytes(utf8.encode(identity.certPem))
    ..usePrivateKeyBytes(utf8.encode(identity.keyPem));
    logger.i('bindAndOpenHTTPSCONNECTION: security context ready, binding server');

     final server = await HttpServer.bindSecure(
      InternetAddress.anyIPv4, 
      0,                       //os pick a free port
      context,
     );
     logger.i('bindAndOpenHTTPSCONNECTION: server bound, start listening');
     server.listen(
      (req)=>ref.read(requestRouterServiceProvider.notifier).handleRequest(req, token),
      onError: (e) => logger.e('server error: $e'),
      onDone: () => logger.i('Server closed !') ,
     );
      _server = server;
      logger.i('HTTPS server listening on port ${server.port}');
     return server.port; 

  } catch(e){
    logger.e(e);
    return null;
  }
    
  }

  

  @override
  Future<ProcessStartReturn?> startProcess() async {
    try{
      if(ref.read(currentServerStateProvider.notifier).geCurrentState() != ServerStates.terminated) return null;
      ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.starting);
      //fetching identity keys locally :
    GeneratedIdentity? identity = await ref.read(identityGenerationProvider.notifier).getGeneratedIdentity();
    final deviceTokenData = ref.read(deviceTokenProvider); //loading device token
    if(deviceTokenData == null){
        ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.terminated);
        return null;
      }
    if(identity == null){
      
      
      final devicename = deviceTokenData.deviceName;
      try{
      await ref.read(identityGenerationProvider.notifier).generateIdentityAndStoreIt(devicename);
      identity = await ref.read(identityGenerationProvider.notifier).getGeneratedIdentity();
      if(identity == null){
        ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.terminated);
        return null;//give up
      }
      } catch(e){
        ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.terminated);
        logger.e(e);
        return null;
      }
    }

    //generating one-time token 
    final token = ref.read(qrCodeServiceProvider.notifier).generateOneTimeToken(length: 12);
    if(token == null){
      ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.terminated);
       return null;
    }
    
   
  
  //binding https server

  final port = await bindAndOpenHTTPSCONNECTION(identity: identity, token: token);
  
  if(port == null){
    ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.terminated);
    return null;
  }

  //starting the mDNS service
  await ref.read(multicastDnsServiceProvider.notifier).sendMDNS(devicename: deviceTokenData.deviceName, deviceID: deviceTokenData.uniqueDeviceAccountId, port: port);
  
   //generating Qr code payload

   final jsonQRcodeData =ref.read(qrCodeServiceProvider.notifier).generateQrCodePayLoad(
    deviceId: deviceTokenData.uniqueDeviceAccountId,
    fingerPrint: ref.read(identityGenerationProvider.notifier).extractFingerPrintFromCertificate(cert: identity.certPem),  //extracting finger print from the certificate
    token: token
   );

   
   ref.read(timerHelperProvider.notifier).startTimer(stopProcess, seconds: firstScanSeconds);

   //TODO remember to delete it
   final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
for (final i in interfaces) {
  for (final a in i.addresses) {
    logger.i('DEBUG interface ${i.name}: ${a.address}');
  }
}
    logger.i("data :$port , $token ");
    ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.waitingToScanQrCode);

    return ProcessStartReturn(jsonQRcodeData: jsonQRcodeData );
  
    } catch(e){
      logger.e(e);
      await stopProcess(); //stop process handle to change the current server state
      return null;
    }
    
  }

  @override
  Future<void> stopProcess() async {
    try{
      ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.stopping);
      ref.read(timerHelperProvider.notifier).stopTimer();
     
    await ref.read(multicastDnsServiceProvider.notifier).unregisterMdns();
    await stopServer();

    }catch(e){
      logger.e("failed to stop the process" , error: e);
    } finally{
      ref.read(currentServerStateProvider.notifier).changeCurrentState(ServerStates.terminated);
    }

  }
    
  

  @override
  Future<void> stopServer()async {
    final server = _server;
  if (server == null) return; 
  try {
    logger.i('stopServer: closing server');
    await server.close(force: true);
    logger.i('stopServer: closed');
  } catch (e) {
    logger.e(e);
  } finally {
    _server = null; 
  }
    
  }

}

final serverSetUpProvider = NotifierProvider<ServerSetUp,void>((){
  return ServerSetUp();
});