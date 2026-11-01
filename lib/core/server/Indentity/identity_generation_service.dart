import 'dart:isolate';

import 'package:basic_utils/basic_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/SecureStorage/SecureStorageServices/LocalServer/local_server_secure_storage_service.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/Indentity/identity_generation_domain.dart';
import 'package:logger/logger.dart';

class IdentityGenerationService extends Notifier<void> implements IndentityGenerationDomain {
  late Logger logger;
  @override
  void build() {
    logger = ref.read(loggerProvider);
    
  }

  @override
  String extractFingerPrintFromCertificate({required String cert}) {
     logger.i('extractFingerPrintFromCertificate: converting PEM to DER bytes');
  final der = CryptoUtils.getBytesFromPEMString(cert); 
  logger.i('extractFingerPrintFromCertificate: DER length ${der.length} bytes, hashing');
  final fingerprint = sha256.convert(der).toString(); 
  logger.i('extractFingerPrintFromCertificate: fingerprint $fingerprint');
  return fingerprint;
    
  }

  @override
  Future<void> generateIdentityAndStoreIt(String devicename) async {
    try{
      logger.i("generating identity for device name : $devicename");
    //it is a heavy opearation , so we run it in an isolte to prevent ui freezing
    final data = await Isolate.run((){
      final pair = CryptoUtils.generateRSAKeyPair(keySize: 2048); // Asymmetric key pairs
      final privateKey = pair.privateKey as RSAPrivateKey ;
      final publicKey = pair.publicKey as RSAPublicKey;

      final csr  = X509Utils.generateRsaCsrPem({'CN': devicename}, privateKey, publicKey);
      final cert = X509Utils.generateSelfSignedCertificate(privateKey, csr, 3650); //arround 10 year , we won't really gonna check the expiry date , no benefits for the current model
      final key  = CryptoUtils.encodeRSAPrivateKeyToPem(privateKey);
      return (cert , key);

    });
    logger.i("generated identity succesfly , writing them locally");
    await ref.read(localServerSecureStorageServiceProvider.notifier).writeIdentity(GeneratedIdentity(data.$1, data.$2));
    } catch(e){
      logger.e(e);
      rethrow;
    }
   
    
  }

  @override
  Future<GeneratedIdentity?> getGeneratedIdentity() async {
      try{
      logger.i("reading identity locally");
      final data = await ref.read(localServerSecureStorageServiceProvider.notifier).readIdentity();
      if(data == null) logger.i("data identity is null");
      return data;
    } catch(e){
      logger.e(e);
      rethrow;
    }
    
  }

}


final identityGenerationProvider =  NotifierProvider<IdentityGenerationService,void>((){
  return IdentityGenerationService();
});