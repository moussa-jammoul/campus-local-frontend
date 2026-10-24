
// ignore_for_file: unused_field, non_constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

class SecureStore extends Notifier<void> {
  late Logger logger;
  late FlutterSecureStorage securestorage;
  static String? _KCERT; 
  static String? _KSECRETKEY;

  @override
  void build() {
    logger = ref.read(loggerProvider);
    securestorage = FlutterSecureStorage();
  }
  

  //initializing key names , because they depend on device unique id
  void initKeys({
    String? cert,
    String? secretkeyserver
  }){
    _KCERT = cert;
    _KSECRETKEY = secretkeyserver;
  }

  Future<void> writeServerCertification(String cert) async{
    if(_KCERT != null) throw Error();
    try{
      await securestorage.write(key: _KCERT!, value: cert);
    } catch(e){
      logger.e(e);
      rethrow;
    }
  }

  Future<void> writeSevrerSecretKey(String secret) async{
    if(_KSECRETKEY != null) throw Error();
    try{
      await securestorage.write(key: _KSECRETKEY!, value: secret);
    } catch(e){
      logger.e(e);
      rethrow;
    }
  }

  Future<String?> readServerCertification() async {
     if(_KCERT != null) throw Error();
  try {
    
    if (!await securestorage.containsKey(key: _KCERT!)) return null;
    return await securestorage.read(key: _KCERT!);
  } catch (e) {
    logger.e(e);
    return null;
  }
}

  Future<String?> readServerSecretKey() async {
    if(_KSECRETKEY != null) throw Error();
  try {
    if (!await securestorage.containsKey(key: _KSECRETKEY!)) return null;
    return await securestorage.read(key: _KSECRETKEY!);
  } catch (e) {
    logger.e(e);
    return null;
  }

  }
}

final secureStorageProvider = NotifierProvider<SecureStore,void>((){
  return SecureStore();
});