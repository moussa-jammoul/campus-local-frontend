import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/card_style.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/service/home_page_services.dart';

class OpenConnectionToSendMedia extends ConsumerStatefulWidget {
  const OpenConnectionToSendMedia({super.key});

  @override
  ConsumerState<OpenConnectionToSendMedia> createState() =>
      _OpenConnectionToSendMediaState();
}

class _OpenConnectionToSendMediaState
    extends ConsumerState<OpenConnectionToSendMedia> {
  bool _isTaped = false;

  Future<void> _onTap() async {
    if (_isTaped) return; 
    setState(() => _isTaped = true);
    try {
      await ref
          .read(homePageServiceProvider.notifier)
          .openSecureServerConnection();
    } finally {
     
      if (mounted) setState(() => _isTaped = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return CardStyleWidget(
      child: Row(
        spacing: 10,
        children: [
          Icon(
            Icons.wifi_tethering_rounded,
            color: scheme.primary,
          ),
          SizedBox(
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Open Secure Connection',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Opens a secure, local connection to send media directly between your devices.',
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
                onTap: _onTap,
                child: Ink(
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Center(
                      child: _isTaped
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                          
                              ),
                            )
                          : Icon(
                              Icons.lock_outline_rounded,
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