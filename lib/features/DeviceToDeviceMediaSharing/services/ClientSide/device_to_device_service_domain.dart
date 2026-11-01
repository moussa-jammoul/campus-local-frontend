import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_media.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/form.dart';

abstract class DeviceToDeviceServiceDomain {
  Future<List<MediaUUIDandTYPE>?> fetchAllUnvailableMediaLocally();
  Future<void> browseAvailableDevices();//use the mDNS method with a service type , then we send results to the state , it is a listener function that keep updated
  Future<void> stopBrowsingDevices(); //stop disvocering devices , usually when the user exist the explore sheet or choose one
  Future<void> sendRequestAndStreamReceivedDataLocally(String uuid , String type);
  Future<QrCodePayLoad?> extractFingerPrintAndTokenFromQRCODE(String json);
  Future<void> startProcess();
  Future<void> stopProcess();
}