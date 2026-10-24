import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/secure_storage.dart';

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