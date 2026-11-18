import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/ServerSetup/timer_helper.dart';
import 'package:flutterfrontenduniprojectmanager/core/server/current_server_state.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/services/SevrerSide/server_side_d2d.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';

class InProcessD2dWaitingSheetDifferentAccount extends ConsumerStatefulWidget {
  const InProcessD2dWaitingSheetDifferentAccount({super.key});

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
      builder: (_) => const InProcessD2dWaitingSheetDifferentAccount(),
    );
  }

  @override
  ConsumerState<InProcessD2dWaitingSheetDifferentAccount> createState() => _InProcessD2dWaitingSheetState();
}

class _InProcessD2dWaitingSheetState extends ConsumerState<InProcessD2dWaitingSheetDifferentAccount> {

  bool _closed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _startListening(); 
    });
  }

  ///listening is to detect automaticaly auto-closure of the sheet , if the time run out , or the process is stopped
  void _startListening() {
    ref.listenManual<ServerStates>(currentServerStateProvider, (previous,next){
      if(
        (previous == null || previous == ServerStates.processing || previous == ServerStates.idle)  
        &&
        (next == ServerStates.stopping || next == ServerStates.terminated)
        ){
          _closeSheet();
        }
    } , fireImmediately: true);
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

    return PopScope(
      canPop: false,
      child: ClipRRect(
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
                      'Sending Media',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sending Media may take time , please wait',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // no value: endless moving bar, no numbers
                    LinearProgressIndicator(
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    const SizedBox(height: 12),

                    if (secondsLeft != null)
                      Text(
                        'Auto abort in ${secondsLeft ~/ 60}:${(secondsLeft % 60).toString().padLeft(2, '0')}',
                        style: theme.textTheme.bodySmall,
                      ),

                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () async {
                        final serverD2D = ref.read(serverServicerD2DDifferentAccountProvider.notifier);
                        await serverD2D.stopServerD2D();
                        _closeSheet(); // guarded, pops only once
                      },
                      child: const Text('Abort'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}