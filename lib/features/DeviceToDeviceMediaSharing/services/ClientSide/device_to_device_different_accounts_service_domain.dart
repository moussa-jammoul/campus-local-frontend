import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/choosing_location_to_save_media_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharingSameAccount/services/ClientSide/form.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
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