import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/providers/number_files_recieved.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/client_side_current_state.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/device_to_device_service.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';

class ReceivingFilesD2dSheet extends ConsumerStatefulWidget {

  const ReceivingFilesD2dSheet({
    super.key,
    required this.media , 
    required this.rawQrCode
    });

    final List<MediaForm> media;
    final String rawQrCode;


  //using the context of the navigator , please if you want any time in the future to change and use 
  //shell routes , make sure to use the root navigator root context 
  static Future<void> show({
    required List<MediaForm> media , 
    required String rawQrCode
    
  }) async {
    final ctx = navigatorKey.currentContext;
    if(ctx == null) {
      return;
    }

    return showModalBottomSheet<void>(
      context: ctx,
      isDismissible: false,   
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (_) => ReceivingFilesD2dSheet(media: media , rawQrCode: rawQrCode, ),
    );
  }

  @override
  ConsumerState<ReceivingFilesD2dSheet> createState() => _ReceivingFilesD2dSheetState();

}



class _ReceivingFilesD2dSheetState extends ConsumerState<ReceivingFilesD2dSheet> {

  bool _closed = false;
 

  Future<void> startTheProcess() async{
    
    try{
    await ref.read(devicetodeviceServiceClientSideProvider.notifier).startProcess(
      mediaThatDoesntExistLocally: widget.media, 
      rawQrCodeData: widget.rawQrCode
      );
      
    } catch(e){
        final ctx = navigatorKey.currentState?.context;
        if(ctx == null) return;
        if(ctx.mounted){
        ScaffoldMessenger.of(ctx)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          "Process Failed .\nPlease make sure both devices on the same network , and belong to the same account",   
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
      }
    } finally{
      _closeSheet();
    }

  }  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    if (!mounted) return;
    startTheProcess();
     _startListening(); 
  });
   
  }

  
  void _startListening() {
    

    ref.listenManual<int?>(filesRecievedProvider, (previous,next){
      if(previous != null && next == 0){
        _closeSheet();
      }

    });
  }

  void _closeSheet() {
    if (_closed || !mounted) return;
    _closed = true;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final nbFilesRecieved = ref.watch(filesRecievedProvider);

      
    final maxNBFiles = ref.read(filesRecievedProvider.notifier).getMax();
    
    return
    PopScope(
      canPop: false,
      child: 
     ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.75),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(
              top: BorderSide(color: theme.colorScheme.onSurface.withValues(alpha: 0.08)),
            ),
          ),
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Recieving files',
                     textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                   'Recieving files may take time ,please do not close the app',
                    
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 20),
                
                  LinearProgressIndicator(
  value: (maxNBFiles != null && nbFilesRecieved != null && maxNBFiles > 0)
      ? (nbFilesRecieved) / maxNBFiles
      : null, // endless animation while the total is unknown
  minHeight: 10,
  borderRadius: BorderRadius.circular(8),
),
const SizedBox(height: 12),

Text(
  (maxNBFiles != null && nbFilesRecieved != null)
      ? '$nbFilesRecieved of $maxNBFiles files recieved'
      : 'Preparing...',
  style: Theme.of(context).textTheme.titleMedium,
),
const SizedBox(height: 16),
 
                  TextButton(
                    onPressed: () async {
                     
                      _closed = true; 
                      Navigator.of(context).pop();
                      ref.read(clientSideCurrentStateProvider.notifier).changeCurrentState(ClientSideD2DState.aborted);
                    },
                    child: const Text('Cancel'),
                  ),

                  const SizedBox(height: 12),
                  
                
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}