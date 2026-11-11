import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/services/ClientSide/form.dart';

abstract class DeviceToDeviceDifferentAccountsServiceDomain {
   Future<void> sendReqAndstreamReceivedDataLocally({
    required int timeOut,
    required String token,
    required int port,
    required String ipAddress,
    required String expectedFingerprint,
  });
  QrCodePayLoad? extractDataFromQRCODE(String json);
  Future<void> startProcess({
    required String rawQrCodeData
    });

}