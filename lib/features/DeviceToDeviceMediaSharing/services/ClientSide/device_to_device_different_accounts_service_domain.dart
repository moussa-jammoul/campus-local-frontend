import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/choosing_location_to_save_media_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/services/ClientSide/form.dart';

abstract class DeviceToDeviceDifferentAccountsServiceDomain {
   Future<void> sendReqAndstreamReceivedDataLocally({
    required int timeOut,
    required String token,
    required int port,
    required String ipAddress,
    required String expectedFingerprint,
    required SaveLocation path,
  });
  QrCodePayLoadDifferentAccounts? extractDataFromQRCODE(String json);
  Future<void> startProcess({
    required String rawQrCodeData
    });

}