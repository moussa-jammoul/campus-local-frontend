import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/constantversions.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/qrCode/qrcode_service_domain.dart';
import 'package:logger/logger.dart';


///this class is the base of any other qr code generator related to the server start up , 
///whenever you want to add extra data to the qr code  , override the generator, something like
/// .... extend QrcodeService {
/// @override
/// ....
/// }
/// or if no need to extra stuff but the base , use this service directly via
/// generate qr pay load



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

