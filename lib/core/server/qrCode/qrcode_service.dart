import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/constantversions.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/qrCode/qrcode_service_domain.dart';
import 'package:logger/logger.dart';

class QrcodeService extends Notifier<void> implements QrcodeServiceDomain {
  late Logger logger;
  @override
  void build() {
    logger = ref.read(loggerProvider);
    
  }

  @override
  String? generateOneTimeToken({required int length}) {
    try{
logger.i('generateOneTimeToken: generating token of length $length');
const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
final rng = Random.secure();
final token = List.generate(length, (_) => chars[rng.nextInt(chars.length)]).join();
logger.i('generateOneTimeToken: token generated');

return token;
  } catch(e){ //possible if the current platform does not support cryptographically secure source
    logger.e(e);
    return null;
  }
   
  }

  @override
  String generateQrCodePayLoad({required String token, required String fingerPrint, required String deviceId}) {
    logger.i('generateQrCodePayLoad: building payload for device $deviceId');
  final json =  jsonEncode({
    "v" : qRCODEVERSIONPROTOCOL , //version protocol
    "t" : token,
    "fp" : fingerPrint,
    "id" : deviceId
  }); 
  return json;
  }

}


final qrCodeServiceProvider = NotifierProvider<QrcodeService ,void>((){
  return QrcodeService();
});

