import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/ServerSetup/form.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
abstract class ServerSetUpDomain {
  Future<int?> bindAndOpenHTTPSCONNECTION({
    required GeneratedIdentity identity, 
    required String token,
  }); //return port number
  
  Future<void> stopServer(); //stop the server itself


  Future<ProcessStartReturn?> startProcess();
  Future<void> stopProcess(); //stop thr whole process (e.g the server , unregister mdns ...) and clean lefts

}