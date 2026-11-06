import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_media.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/form.dart';

abstract class DeviceToDeviceServiceDomain {
  Future<List<MediaUUIDandTYPE>?> fetchAllUnvailableMediaLocally();
  Future<void> sendRequestAndStreamReceivedDataLocally(String uuid , String type);
  Future<QrCodePayLoad?> extractDataFromQRCODE(String json);
  Future<void> startProcess();
  Future<void> stopProcess();
}