// ignore_for_file: avoid_print

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/receiving_files_d2d_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ClientSide/device_to_device_service.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/ServerSide/server_side_service.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrCodeSheet extends ConsumerStatefulWidget {
  

  final List<MediaForm> media; 
  static bool _isOpen = false;

  const ScanQrCodeSheet({super.key , required this.media});


  static Future<String?> showSheet(List<MediaForm> media) async {
    if (_isOpen) return null;

    final ctx = navigatorKey.currentContext;
    if (ctx == null) return null; 

    _isOpen = true;
    try {
      return await showModalBottomSheet<String>(
        context: ctx,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withValues(alpha: 0.3),
        builder: (_) => ScanQrCodeSheet(media: media,),
      );
    } finally {
      _isOpen = false;
    }
  }

  @override
  ConsumerState<ScanQrCodeSheet> createState() => _ScanQrCodeSheetState();
}

class _ScanQrCodeSheetState extends ConsumerState<ScanQrCodeSheet> {
  final MobileScannerController _controller = MobileScannerController(
    formats: [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  bool _closed = false; 

  void _onDetect(BarcodeCapture capture) async {
    if (_closed) return;
    final raw = capture.barcodes.firstOrNull?.rawValue;
    if (raw == null) return;
    _closeSheet();
    ReceivingFilesD2dSheet.show(
      rawQrCode: raw,
      media: widget.media
    );

    
  }

  void _closeSheet() {
    if (_closed || !mounted) return;
    _closed = true;
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: scheme.surface.withValues(alpha: 0.75),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(
              top: BorderSide(color: scheme.onSurface.withValues(alpha: 0.08)),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Scan QR Code',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),

                
                  SizedBox(
                    width: 280,
                    height: 280,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: MobileScanner(
                        controller: _controller,
                        onDetect: _onDetect,
                        errorBuilder: (context, error) => Container(
                          color: scheme.surfaceContainerHighest,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Camera error: failed to open the camera , please make sure to accept camera permission',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: scheme.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  ValueListenableBuilder<MobileScannerState>(
                    valueListenable: _controller,
                    builder: (context, state, _) {
                      final torchOn = state.torchState == TorchState.on;
                      final unavailable = state.torchState == TorchState.unavailable;
                      return FilledButton.icon(
                        onPressed: unavailable ? null : _controller.toggleTorch,
                        icon: Icon(torchOn ? Icons.flashlight_off_rounded : Icons.flashlight_on_rounded),
                        label: Text(torchOn ? 'Turn off torch' : 'Turn on torch'),
                      );
                    },
                  ),
                   const SizedBox(height: 4),
                  TextButton(
                    onPressed: _closeSheet,
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}