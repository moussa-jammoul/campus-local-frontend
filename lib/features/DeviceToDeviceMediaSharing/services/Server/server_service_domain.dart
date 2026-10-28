import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';


///right now the project doesn't really need to split between the server set up and the device to device sending media (handlers) ,
///whenever the project require this , we can move the set up to "core" and left the extra steps and handlers here.

abstract class ServerServiceDomain {
  Future<void> generateIdentityAndStoreIt(String devicename);//generate a secret key and a certificate for the https protocol

  Future<GeneratedIdentity?> getGeneratedIdentity();


  Future<void> sendMDNS({
    required String devicename,
    required String deviceID,
    required int port,
    //ip handled by mDNS , protocol version and service type hardcoded in the function itself
  });

  Future<int?> bindAndOpenHTTPSCONNECTION({
    required GeneratedIdentity identity, 
    required String token,
  }); //we receive here requests , validate them  , and stream the media to the receiver device , we return the port number

  String? generateOneTimeToken({required int length});

  String extractFingerPrintFromCertificate({
    required String cert
  });

  void generateQrCodePayLoad({ //transform data into json so we use them to generate qr code (we push the data to a provider)
    required String token,
    required String fingerPrint,
    required String deviceId,
  });
  
  Future<void> stopMdns();
  Future<void> stopServer();
  
  Future<void> startProcess();
  Future<void> stopProcess();// unregister mDNS , clear state  , stop the connection...

}