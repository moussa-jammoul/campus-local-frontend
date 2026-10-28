abstract class ServerSetUpDomain {
  Future<int?> bindAndOpenHTTPSCONNECTION({
    required GeneratedIdentity identity, 
    required String token,
  }); //return port number

  Future<void> startProcess();
  Future<void> stopProcess();

}