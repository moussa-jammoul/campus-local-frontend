import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/secure_storage.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
class LocalServerSecureStorageService extends Notifier<void> {
  @override
  void build() {}

  Future<void> writeIdentity(GeneratedIdentity identity) async {
    final storage = ref.read(secureStorageProvider.notifier);
    await storage.writeServerCertification(identity.certPem);
    await storage.writeSevrerSecretKey(identity.keyPem);
  }

  Future<GeneratedIdentity?> readIdentity() async {
    final storage = ref.read(secureStorageProvider.notifier);
    final cert = await storage.readServerCertification();
    final key = await storage.readServerSecretKey();

    if (cert == null || key == null) return null; 
    return GeneratedIdentity(cert, key);
  }
}

final localServerSecureStorageServiceProvider = NotifierProvider<LocalServerSecureStorageService,void>((){
  return LocalServerSecureStorageService();
});