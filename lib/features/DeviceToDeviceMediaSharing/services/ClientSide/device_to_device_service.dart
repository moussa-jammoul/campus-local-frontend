import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_media.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/device_to_device_service_domain.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/form.dart';

class DeviceToDeviceService extends Notifier<void> implements DeviceToDeviceServiceDomain {
  

  @override
  void build() {
    
  }


  @override
  Future<List<MediaUUIDandTYPE>?> fetchAllUnvailableMediaLocally() {
    // TODO: implement fetchAllUnvailableMediaLocally
    throw UnimplementedError();
  }

  @override
  Future<void> sendRequestAndStreamReceivedDataLocally(String uuid, String type) {
    // TODO: implement sendRequestAndStreamReceivedDataLocally
    throw UnimplementedError();
  }

  @override
  Future<void> startProcess() {
    // TODO: implement startProcess
    throw UnimplementedError();
  }

  @override
  Future<void> stopProcess() {
    // TODO: implement stopProcess
    throw UnimplementedError();
  }

  @override
  Future<QrCodePayLoad?> extractDataFromQRCODE(String json) {
    // TODO: implement extractDataFromQRCODE
    throw UnimplementedError();
  }

}