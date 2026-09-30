import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/widgets/card_style.dart';

class FetshAnyMissedMediaButton extends ConsumerWidget {
  const FetshAnyMissedMediaButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardStyleWidget(
      child: Row(
        spacing: 10,

        children: [
          Icon(
            Icons.file_download,
            color: Theme.of(context).colorScheme.primary,
          ),

          SizedBox(
  width: 170,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Fetch Unavailable Media',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        'Media is stored on the device it was added from, not on a server, Fetching pulls anything missing here directly from your other linked devices.',
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[600],
        ),
      ),
    ],
  ),
),
        Flexible(child: 
        Material(
  color: Colors.transparent,
  child: InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () {
      // TODO: fetch missing media
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
          Icons.download,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        )
      ),
    ),
  ),
),
        )

        ],
      )
      );
  
  }


}