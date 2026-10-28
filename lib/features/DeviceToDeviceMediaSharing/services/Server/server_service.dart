// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'package:basic_utils/basic_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/local_server_secure_storage_service.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/device_token_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/providers/number_files_left.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/providers/qrcode.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/Server/server_service_domain.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/Server/timer_helper.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/constants.dart';
import 'package:logger/logger.dart';
import 'package:nsd/nsd.dart';

///right now the project doesn't really need to split between the server set up and the device to device sending media (handlers) ,
///whenever the project require this , we can move the set up to "core" and left the extra steps and handlers here.

class ServerService extends Notifier<void> implements ServerServiceDomain {

  

  late Logger logger;
  HttpServer? _server;

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }


 @override
Future<int?> bindAndOpenHTTPSCONNECTION({
  required GeneratedIdentity identity, 
  required String token,
}) async {
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
      (req)=>_handleRequest(req, token),
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
//how to stop the process ? two case :1- read the header which mention the number of file needed , we store it locally , we keep decreasing it on each request , when it is zero , we end the server
//2- we run a timer between two idle time of requests , when it exceed the timer , we stop the process , it mean we lost the connection from the receiver side


static const _firstScanSeconds = 2000; // waiting for the QR scan
static const _idleSeconds = 2000;      // gap between two requests

Future<void> _handleRequest(HttpRequest req , String token) async{
  try{
    
    logger.i('_handleRequest: ${req.method} ${req.uri.path} from ${req.connectionInfo?.remoteAddress.address}');
    //validating the token
    final tokenFromReq = req.headers.value('x-token');

    //no need to really take care about a timing attack , it is just a simple short and short-lived token over two devices in a LAN which take nano seconds to compare 
    if(tokenFromReq == null || token != tokenFromReq){
      logger.i('_handleRequest: token missing or invalid, answering 401');
      req.response.statusCode = HttpStatus.unauthorized;
      await req.response.close();
      return;
    }
    logger.i('_handleRequest: token valid');

  
    if(ref.read(filesLeftProvider) == null){
      final headerNbFile = req.headers.value('x-files-number');
      if(headerNbFile == null){
         logger.i('_handleRequest: missing number of files , rejecting the request...');
         req.response.statusCode = HttpStatus.badRequest;
         await req.response.close();
         return;
      }
      final resultNBFILES = int.tryParse(headerNbFile);
      
      if(resultNBFILES == null || resultNBFILES <= 0){
        logger.i('_handleRequest: bad request');
         req.response.statusCode = HttpStatus.badRequest;
         await req.response.close();
         return;
      }
      ref.read(filesLeftProvider.notifier).setTotal(resultNBFILES);
    }

  final segments = req.uri.pathSegments;//something like /files/uuid of the media
  if (req.method == 'GET' && segments.length == 2 && segments[0] == 'files') {
    
    
    ref.read(timerHelperProvider.notifier).stopTimer(); 
    
   
    try{
      logger.i('_handleRequest: file request for uuid ${segments[1]}');
      await _sendFile(req, segments[1]);
      logger.i('_handleRequest: file request finished for uuid ${segments[1]}');
    } finally {
      //success or failure the requester will not ask again for this file , until the user re-run the process
      final left = ref.read(filesLeftProvider.notifier).decrement();
      logger.i('_handleRequest: files left = $left');

      if(left != null && left <= 0){
       
        await Future.delayed(const Duration(seconds: 1)); //small gap , so the receiver finish reading and storing , so they feel that both finish the job at the same time 
        await stopProcess();
      } else {
        //start the timer to cover the gap time
        ref.read(timerHelperProvider.notifier).startTimer(stopProcess, seconds: _idleSeconds);
      }
    }
    return;
  }

  //if validating the method and segments failed :
  logger.i('_handleRequest: unknown route, answering 404');
  req.response.statusCode = HttpStatus.notFound;
  await req.response.close();

  } catch(e){
    logger.e(e);
    
    try {
    logger.i('_handleRequest: error happened, answering 500');
    req.response.statusCode = HttpStatus.internalServerError;
    await req.response.close();
    } catch (_) {}
    
  }
}

Future<void> _sendFile(HttpRequest req, String uuid) async {
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
}

@override
String extractFingerPrintFromCertificate({
  required String cert
}) {
  logger.i('extractFingerPrintFromCertificate: converting PEM to DER bytes');
  final der = CryptoUtils.getBytesFromPEMString(cert); 
  logger.i('extractFingerPrintFromCertificate: DER length ${der.length} bytes, hashing');
  final fingerprint = sha256.convert(der).toString(); 
  logger.i('extractFingerPrintFromCertificate: fingerprint $fingerprint');
  return fingerprint;
}

@override
String? generateOneTimeToken({required int length}) {
  try{
logger.i('generateOneTimeToken: generating token of length $length');
const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
final rng = Random.secure();
final token = List.generate(length, (_) => chars[rng.nextInt(chars.length)]).join();
logger.i('generateOneTimeToken: token generated');

return token;
  } catch(e){ //possible if the current platform does not support cryptographically secure source
    logger.e(e);
    return null;
  }
}

@override
void generateQrCodePayLoad({
  required String token,
  required String fingerPrint,
  required String deviceId,
})  {
  logger.i('generateQrCodePayLoad: building payload for device $deviceId');
  final json =  jsonEncode({
    "v" : qRCODEVERSIONPROTOCOL , //version protocol
    "t" : token,
    "fp" : fingerPrint,
    "id" : deviceId
  }); 
  ref.read(qrCodeDataProvider.notifier).addData(json);
  logger.i('generateQrCodePayLoad: payload sent to qrCodeDataProvider');
}
  

  @override
  Future<void> generateIdentityAndStoreIt(String devicename) async {
    try{
      logger.i("generating identity for device name : $devicename");
    //it is a heavy opearation , so we run it in an isolte to prevent ui freezing
    final data = await Isolate.run((){
      final pair = CryptoUtils.generateRSAKeyPair(keySize: 2048); // Asymmetric key pairs
      final privateKey = pair.privateKey as RSAPrivateKey ;
      final publicKey = pair.publicKey as RSAPublicKey;

      final csr  = X509Utils.generateRsaCsrPem({'CN': devicename}, privateKey, publicKey);
      final cert = X509Utils.generateSelfSignedCertificate(privateKey, csr, 3650); //arround 10 year , we won't really gonna check the expiry date , no benefits for the current model
      final key  = CryptoUtils.encodeRSAPrivateKeyToPem(privateKey);
      return (cert , key);

    });
    logger.i("generated identity succesfly , writing them locally");
    await ref.read(localServerSecureStorageServiceProvider.notifier).writeIdentity(GeneratedIdentity(data.$1, data.$2));
    } catch(e){
      logger.e(e);
      rethrow;
    }
    
  }
  

  //Return null mean it doesn't exist locally so we generate it, if "throw" , error happened 
  @override
  Future<GeneratedIdentity?> getGeneratedIdentity() async{
    try{
      logger.i("reading identity locally");
      final data = await ref.read(localServerSecureStorageServiceProvider.notifier).readIdentity();
      if(data == null) logger.i("data identity is null");
      return data;
    } catch(e){
      logger.e(e);
      rethrow;
    }
  }


  
  Registration? _registration;

  @override
  Future<void> sendMDNS({required String devicename, required String deviceID, required int port}) async {
    try {
    logger.i('sendMDNS: registering $devicename on port $port');

    final service = Service(
      name: devicename,        
      type: serviceType,
      port: port,
      txt: {
        'id': utf8.encode(deviceID),                 
        'v': utf8.encode(protocolVersionMDNS.toString()),
      },
    );
    

    _registration = await register(service);
    logger.i('sendMDNS: registered as ${_registration!.service.name}');
  } catch (e) {
    logger.e(e);
    rethrow;
  }

    
  }
  

  ///Multiple steps , connecting everything together , for a better understanding , go to the system choices devicetodevice.drawio ,
  ///open it via drawio in any browser
  @override
  Future<void> startProcess() async {
    
    try{
      if(_server != null) return;
      //fetching identity keys locally :
    GeneratedIdentity? identity = await getGeneratedIdentity();
    final deviceTokenData = ref.read(deviceTokenProvider); //loading device token
    if(deviceTokenData == null){
        throw "System Not initialized yet , please try again a bit later";
      }
    if(identity == null){
      
      
      final devicename = deviceTokenData.deviceName;
      try{
      await generateIdentityAndStoreIt(devicename);
      identity = await getGeneratedIdentity();
      if(identity == null){
        throw Error();//give up
      }
      } catch(e){
        logger.e(e);
        rethrow;
      }
    }

    //generating one-time token 
    final token = generateOneTimeToken(length: 12);
    if(token == null){
      throw Error();
    }
    
   
  
  //binding https server

  final port = await bindAndOpenHTTPSCONNECTION(identity: identity, token: token);
  
  if(port == null){
    throw Error();
  }

  //starting the mDNS service
  await sendMDNS(devicename: deviceTokenData.deviceName, deviceID: deviceTokenData.uniqueDeviceAccountId, port: port);
  
   //generating Qr code payload

   generateQrCodePayLoad(
    deviceId: deviceTokenData.uniqueDeviceAccountId,
    fingerPrint: extractFingerPrintFromCertificate(cert: identity.certPem),  //extracting finger print from the certificate
    token: token
   );

   
   ref.read(timerHelperProvider.notifier).startTimer(stopProcess, seconds: _firstScanSeconds);
   final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
for (final i in interfaces) {
  for (final a in i.addresses) {
    logger.i('DEBUG interface ${i.name}: ${a.address}');
  }
}
    logger.i("data :$port , $token ");//TODO remember to delete
  
    } catch(e){
      logger.e(e);
      await stopProcess();
      rethrow;
    }
  }

  @override
  Future<void> stopMdns() async{
    final reg = _registration;
  if (reg == null) return; 
  try {
    await unregister(reg);
    logger.i('stopMDNS: unregistered');
  } catch (e) {
    logger.e(e);
  } finally {
    _registration = null; 
  }
   
  }

  @override
  Future<void> stopServer() async {
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

  @override
  Future<void> stopProcess() async {
    try{
      
      ref.read(timerHelperProvider.notifier).stopTimer();
      
      ref.read(filesLeftProvider.notifier).reset();
     
      ref.read(qrCodeDataProvider.notifier).clear();
    await stopMdns();
    await stopServer();
    }catch(e){
      logger.e("failed to stop the process" , error: e);
    }
    

  }

 


}


final serverServicerProvider = NotifierProvider<ServerService,void>((){
  return ServerService();
});