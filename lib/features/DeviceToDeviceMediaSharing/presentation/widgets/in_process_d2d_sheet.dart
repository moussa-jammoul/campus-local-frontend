import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/providers/number_files_left.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/Server/timer_helper.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';

class InProcessD2dSheet extends ConsumerStatefulWidget {
  const InProcessD2dSheet({super.key});
  

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
      builder: (_) => const InProcessD2dSheet(),
    );
  }

  @override
  ConsumerState<InProcessD2dSheet> createState() => _InProcessD2dSheetState();
}

class _InProcessD2dSheetState extends ConsumerState<InProcessD2dSheet> {

  bool _closed = false;
  late final int? maxNBFiles;
  

  @override
  void initState() {
    super.initState();
    maxNBFiles = ref.read(filesLeftProvider.notifier).getMax();
    _startListening(); 
  }

  ///listening is to detect automaticaly auto-closure of the sheet , if the time run out , or we receive the first
  ///authorized request which mean the qr code is simply scanned
  void _startListening() {
    
    ///why we are using number of files to detect an authorized request ? 
    ///because how we initialize it , we init it after we receive the first request , and after we validate
    ///the token , which mean the qr code is scanned
    ref.listenManual<int?>(filesLeftProvider, (previous, next) {
      if (previous != null && (next == 0 || next == null)) {
        _closeSheet();
      }
    });

    // Timer ran out while no request ever arrived 
    ref.listenManual<int?>(timerHelperProvider, (previous, next) {
      if (previous != null &&
          next == null ) {
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
    final secondsLeft = ref.watch(timerHelperProvider);
    final nbFilesLeft = ref.watch(filesLeftProvider);
    


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
                    'Sending files',
                     textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                   'Sending files may take time , please do not close the app',
                    
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 20),
                
                  LinearProgressIndicator(
  value: (maxNBFiles != null && nbFilesLeft != null && maxNBFiles! > 0)
      ? (maxNBFiles! - nbFilesLeft) / maxNBFiles!
      : null, // endless animation while the total is unknown
  minHeight: 10,
  borderRadius: BorderRadius.circular(8),
),
const SizedBox(height: 12),

Text(
  (maxNBFiles != null && nbFilesLeft != null)
      ? '${maxNBFiles! - nbFilesLeft} of $maxNBFiles files sent'
      : 'Preparing...',
  style: Theme.of(context).textTheme.titleMedium,
),
const SizedBox(height: 12),

secondsLeft != null
    ? Text(
        'Auto abort in ${secondsLeft ~/ 60}:${(secondsLeft % 60).toString().padLeft(2, '0')}',
        style: Theme.of(context).textTheme.bodySmall,
      )
    : const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
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