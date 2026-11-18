import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/choosing_location_to_save_media_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/scan_qr_code_d2d_different_account.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/device_to_device_different_account_service.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/card_style.dart';

class ScanQrCodeToDownloadMediaTile extends ConsumerWidget {
  const ScanQrCodeToDownloadMediaTile({super.key});
  
  Future<void> startProcess(BuildContext context , WidgetRef ref) async{
    try{
      final service = ref.read(clientSideDifferentAccountServiceD2D.notifier);
      final qrcodeJson = await ScanQrCodeSheetd2dDifferentAccount.showSheet();
      if(qrcodeJson == null) return;


      if(context.mounted){
      ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
        SnackBar(
          content: Text("downloading..."))
        );
      }
      
      await service.startProcess(rawQrCodeData: qrcodeJson);
    }catch(e){
      if(context.mounted){
      ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
        SnackBar(
          content: Text("Failed to start the process , please make sure both devices connected to the same wifi and scan the right qr code"))
        );
      }

    }

  }
  

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    return CardStyleWidget(
      constraints: const BoxConstraints (
        
        minWidth: 350,
        maxWidth: 450,
        ),
      child: Row(
        spacing: 10,
        children: [
          Icon(
            Icons.qr_code_2_outlined,
            color: scheme.primary,
          ),
          SizedBox(
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Scan Qr Code to download Any Media',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'To download any media from any device , open a secure connection in the device that hold the media , then click here to scan the qr code generated and it will automatically download the media.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async{
                  startProcess(context , ref);
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Center(
                      child:  Icon(
                              Icons.qr_code_scanner_rounded,
                              color: scheme.onPrimary,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      );
   
  }

}