import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';

abstract class ServerServiceDomain {
  Future<void> generatedIdentityAndStoreIt();//generate a secret key and a certificate for the https protocol
  Future<GeneratedIdentity?> getGeneratedIdentity();
  Future<bool> checkIfIdentityExist();
  Future<void> sendMDNS({
    required String devicename,
    required String deviceID,
    required int port,
    //ip handled by mDNS , protocol version and service type hardcoded in the function itself
  });
  Future<int> bindAndOpenHTTPSCONNECTION(); //we receive here requests , validate them  , and stream the media to the receiver device , we return the port
  Future<void> generateOneTimeToken();
  Future<void> extractFingerPrintFromCertificate();
  Future<void> generateQrCodePayLoad();
  Future<void> startProcess();
  Future<void> stopProcess();// unregister mDNS , clear state  , stop the connection...

}