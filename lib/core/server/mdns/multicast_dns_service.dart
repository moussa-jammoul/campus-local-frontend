

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/constantversions.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/mdns/multicast_dns_service_domain.dart';
import 'package:logger/logger.dart';
import 'package:nsd/nsd.dart' as dns;


class MulticastDnsService extends Notifier<void> implements MulticastDnsServiceDomain {
  late Logger logger;
  dns.Registration? _registration;

  @override
  void build() {
    logger = ref.read(loggerProvider);
    
  }

  @override
  Future<void> sendMDNS({required String devicename, required String deviceID, required int port}) async {
    try {
    logger.i('sendMDNS: registering $devicename on port $port');

    final service = dns.Service(
      name: devicename,        
      type: serviceType,
      port: port,
      txt: {
        'id': utf8.encode(deviceID),                 
        'v': utf8.encode(protocolVersionMDNS.toString()),
      },
    );
    

    _registration = await dns.register(service);
    logger.i('sendMDNS: registered as ${_registration!.service.name}');
  } catch (e) {
    logger.e(e);
    rethrow;
  }
    
  }

  @override
  Future<void> unregisterMdns() async {
    final reg = _registration;
  if (reg == null) return; 
  try {
    await dns.unregister(reg);
    logger.i('stopMdns: unregistered');
  } catch (e) {
    logger.e(e);
  } finally {
    _registration = null; 
  }
    
  }

}

final multicastDnsServiceProvider = NotifierProvider<MulticastDnsService,void>((){
  return MulticastDnsService();
});