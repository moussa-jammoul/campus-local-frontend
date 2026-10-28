import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/providers/number_files_left.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/providers/qrcode.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/in_process_d2d_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/Server/server_service.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/Server/timer_helper.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeSheet extends ConsumerStatefulWidget {
  const QrCodeSheet({super.key});
  

  //using the context of the navigator , please if you want any time in the future to change and use 
  //shell routes , make sure to use the root navigator root context 
  static Future<void> show() async {
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
      builder: (_) => const QrCodeSheet(),
    );
  }

  @override
  ConsumerState<QrCodeSheet> createState() => _QrCodeSheetState();
}

class _QrCodeSheetState extends ConsumerState<QrCodeSheet> {
  bool _closed = false;

  @override
  void initState() {
    super.initState();
    _startListening(); 
  }

  ///listening is to detect automaticaly auto-closure of the sheet , if the time run out , or we receive the first
  ///authorized request which mean the qr code is simply scanned
  void _startListening() {
    
    ///why we are using number of files to detect an authorized request ? 
    ///because how we initialize it , we init it after we receive the first request , and after we validate
    ///the token , which mean the qr code is scanned
    ref.listenManual<int?>(filesLeftProvider, (previous, next) {
      if (previous == null && next != null) {
        _closeSheet();

        //synchronized with closure of the QR code sheet
        InProcessD2dSheet.show();
        //TODO splitting server set up and d2d feature (moving server set up to core)
      }
    });

    // Timer ran out while no request ever arrived 
    ref.listenManual<int?>(timerHelperProvider, (previous, next) {
      if (previous != null &&
          next == null &&
          ref.read(filesLeftProvider) == null) {
        _closeSheet();
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR code expired')),
        );
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
    final qrJson = ref.watch(qrCodeDataProvider);
    final secondsLeft = ref.watch(timerHelperProvider);

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
                    'Scan the QR code',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                   'Scan this QR code with the device that needs the media. '
                   'Both devices must be on the same Wi-Fi network.',
                    
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // QR area: loading / QR / error
                  SizedBox(
                    width: 260,
                    height: 260,
                    child: qrJson == null
                        ? const Center(child: CircularProgressIndicator())
                        : Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: QrImageView(
                              data: qrJson,
                              version: QrVersions.auto,
                              size: 240,
                              backgroundColor: Colors.white,
                              errorStateBuilder: (context, error) => Center(
                                child: Text(
                                  'Failed to generate the QR code',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: theme.colorScheme.error),
                                ),
                              ),
                            ),
                          ),
                  ),

                  //time left to scan , check "server service" code and "timer helper" for more information about how the timer work
                  if (secondsLeft != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Expires in ${secondsLeft ~/ 60}:${(secondsLeft % 60).toString().padLeft(2, '0')}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],

                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () async {
                      final server = ref.read(serverServicerProvider.notifier);
                      _closed = true; // so no listener tries to pop again
                      Navigator.of(context).pop();
                      await server.stopProcess();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}