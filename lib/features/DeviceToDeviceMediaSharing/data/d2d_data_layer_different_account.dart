// ignore_for_file: unused_element
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

class D2dDataLayerDifferentAccount extends Notifier<void>{

  Dio? endPoint;
  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
   
  }

  String _buildEndPoint({
    required int port,
    required String ipAddress,
  }){
    return "https://$ipAddress:$port/files";

  }
  

  //used to reset the dio
  void killDio(){
    endPoint = null;
  }


  void _buildDio({
    required String endPointPath,
    required int timeOut,
    required String token,
    required String expectedFingerprint,

  }){
    if(endPoint != null) return;
    endPoint = Dio(
      BaseOptions(
        baseUrl: endPointPath,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(minutes: 5),//it should be big enough , because after the client send the request , the user on the server side choose the media which may take time + sending time, at the same time we should not left it null 
        
        queryParameters: {
          'sameAccount':false,
        },
        headers: {
          'x-token' : token,
        }

      )
    );
     
     endPoint!.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
      final client = HttpClient(context: SecurityContext(withTrustedRoots: false));

      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        return sha256.convert(cert.der).toString() == expectedFingerprint;
      };
      return client;
    },
  );

    endPoint!.interceptors.add(InterceptorsWrapper(
       onRequest: (options, handler) {
    logger.i(' requesting :    ${options.method} ${options.path}');   
    handler.next(options);
       },
       onResponse: (response, handler) {
         logger.i("response : ${response.statusCode} : ${response.statusMessage}");
         handler.next(response);
       },
      onError: (e, handler) {
    logger.e('${e.type} ${e.response?.statusCode}');
    handler.next(e);
      },
     
    ));

  }
  
  //we use this to return the stream , the consumer (the function it called) consume it however it want
  //plus the headers , which contain extra data about the file (e.g type , size , name , ...)
  Future<(Stream<Uint8List>,Headers)?> sendRequest({  
    required int timeOut,
    required String token,
    required int port,
    required String ipAddress,
    required String expectedFingerprint
  }) async{
    if(endPoint == null){
      logger.i("Send request : dio end point not initialized yet ,initializing it...");
      final endPointPath = _buildEndPoint(port: port, ipAddress: ipAddress);
      _buildDio(
      endPointPath: endPointPath, 
      timeOut: timeOut, 
      token: token, 
      expectedFingerprint: expectedFingerprint
      );
    }

    try{
      final response = await endPoint!.get<ResponseBody>(
      "", //in the d2d feature different account doesn't need to add or override the 
      options: Options(responseType: ResponseType.stream)
    );
    return (response.data!.stream,response.headers);

    } catch(e){
      logger.e(e);
      return null;
    }

  }



}

final d2dDataLayerDifferentAccountProvider = NotifierProvider<D2dDataLayerDifferentAccount,void>((){
  return D2dDataLayerDifferentAccount();
});