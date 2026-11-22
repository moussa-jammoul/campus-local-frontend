import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_media.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/services/ClientSide/form.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
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