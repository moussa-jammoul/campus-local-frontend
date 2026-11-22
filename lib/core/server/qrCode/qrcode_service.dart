import 'dart:convert';
import 'dart:math';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
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
  String generateQrCodeBasePayLoad({
    required String token, 
    required String fingerPrint, 
    required int port,
    required String ipLAN,
    required String userUid,

    }) {
    logger.i('generateQrCodePayLoad: building payload');
  final json =  jsonEncode({
    "v" : qRCODEVERSIONPROTOCOL , //version protocol
    "t" : token,
    "fp" : fingerPrint,
    "user" : userUid  , //uid of the user generating the qr code
    "port" : port,
    'ip' : ipLAN,
  }); 
  return json;
  }


}


final qrCodeServiceProvider = NotifierProvider<QrcodeService ,void>((){
  return QrcodeService();
});

