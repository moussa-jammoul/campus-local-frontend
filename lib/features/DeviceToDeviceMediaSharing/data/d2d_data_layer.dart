// ignore_for_file: unused_element

import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';

class D2dDataLayer extends Notifier<void>{

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
  

  //used after all requests finished to the same push
  void killDio(){
    endPoint = null;
  }


  void _buildDio({
    required String endPointPath,
    required int timeOut,
    required String token,
    required  int nbOfFiles,
    required String expectedFingerprint,

  }){
    if(endPoint != null) return;
    endPoint = Dio(
      BaseOptions(
        baseUrl: endPointPath,
        connectTimeout: const Duration(seconds: 10),
        headers: {
          'x-token' : token,
          'x-files-number' :  nbOfFiles
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
  Future<Stream<Uint8List>?> sendRequest({ 
    required String fileUuid, 
    required int timeOut,
    required String token,
    required  int nbOfFiles,
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
      nbOfFiles: nbOfFiles , 
      expectedFingerprint: expectedFingerprint
      );
    }

    try{
      final response = await endPoint!.get<ResponseBody>(
      "/$fileUuid",
      options: Options(responseType: ResponseType.stream)
    );
    return response.data!.stream;

    } catch(e){
      logger.e(e);
      return null;
    }

  }



}

final d2dDataLayerProvider = NotifierProvider<D2dDataLayer,void>((){
  return D2dDataLayer();
});