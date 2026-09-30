import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/card_style.dart';

class OpenConnectionToSendMedia extends ConsumerWidget {
  const OpenConnectionToSendMedia({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardStyleWidget(
  child: Row(
    spacing: 10,
    children: [
      Icon(
        Icons.wifi_tethering_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
      SizedBox(
        width: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
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
            onTap: () {
              // TODO: open secure connection via mDNS
            },
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Center(
                  child: Icon(
                    Icons.lock_outline_rounded,
                    color: Theme.of(context).colorScheme.onPrimary,
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