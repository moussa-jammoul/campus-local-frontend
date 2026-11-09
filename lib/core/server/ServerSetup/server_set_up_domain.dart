import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/ServerSetup/form.dart';

abstract class ServerSetUpDomain {
  Future<int?> bindAndOpenHTTPSCONNECTION({
    required GeneratedIdentity identity, 
    required String token,
  }); //return port number
  
  Future<void> stopServer(); //stop the server itself


  Future<ProcessStartReturn?> startProcess();
  Future<void> stopProcess(); //stop thr whole process (e.g the server , unregister mdns ...) and clean lefts

}