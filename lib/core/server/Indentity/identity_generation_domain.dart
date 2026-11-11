import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';

abstract class IndentityGenerationDomain {
  Future<void> generateIdentityAndStoreIt(String devicename);//generate a secret key and a certificate for the https protocol

  Future<GeneratedIdentity?> getGeneratedIdentity();

  Future<void> updateCertificateIfExpired(String devicename);
  

  bool isExpiringSoon(String cert , {required int withinHour});

  String extractFingerPrintFromCertificate({
    required String cert
  });

}