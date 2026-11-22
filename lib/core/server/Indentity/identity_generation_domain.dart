import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
abstract class IndentityGenerationDomain {
  Future<void> generateIdentityAndStoreIt(String devicename);//generate a secret key and a certificate for the https protocol

  Future<GeneratedIdentity?> getGeneratedIdentity();

  Future<void> updateCertificateIfExpired(String devicename);
  

  bool isExpiringSoon(String cert , {required int withinHour});

  String extractFingerPrintFromCertificate({
    required String cert
  });

}