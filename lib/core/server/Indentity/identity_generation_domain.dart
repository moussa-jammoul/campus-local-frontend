import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';

abstract class IndentityGenerationDomain {
  Future<void> generateIdentityAndStoreIt(String devicename);//generate a secret key and a certificate for the https protocol

  Future<GeneratedIdentity?> getGeneratedIdentity();
  
  String extractFingerPrintFromCertificate({
    required String cert
  });

}