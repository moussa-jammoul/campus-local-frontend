import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_media.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/form.dart';

abstract class DeviceToDeviceServiceDomain {
  Future<List<MediaForm>?> fetchAllUnvailableMediaLocally();
  Future<void> sendReqAndstreamReceivedDataLocally({
    required MediaForm mediaInfo,
    required int timeOut,
    required String token,
    required int nbOfFiles,
    required int port,
    required String ipAddress,
    required String expectedFingerprint,
  });
  QrCodePayLoad? extractDataFromQRCODE(String json);
  Future<void> startProcess({
    required List<MediaForm> mediaThatDoesntExistLocally,
    required String rawQrCodeData
    });
}