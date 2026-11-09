import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/DeviceToDeviceMediaSharing/presentation/widgets/mobile_qr_code_scanner.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';

class NumberOfFilesThatDoesntExistLocallySheet extends ConsumerStatefulWidget {
  const NumberOfFilesThatDoesntExistLocallySheet({super.key, required this.media});

  final List<MediaForm> media;

 
  static bool _isOpen = false;

 
  static Future<void> showSheet({
    required List<MediaForm> media,
  }) async {
     final ctx = navigatorKey.currentContext;
    if(ctx == null) {
      return;
    }
    
    if (_isOpen) return;
    _isOpen = true;

    try {
      await showModalBottomSheet<void>(
        context: ctx,
        //please make sure if u want to change the current root to a shell route add here use navigator root
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withValues(alpha: 0.3),
        builder: (_) => NumberOfFilesThatDoesntExistLocallySheet(media: media),
      );
    } finally {
      _isOpen = false; 
    }
  }

  @override
  ConsumerState<NumberOfFilesThatDoesntExistLocallySheet> createState() =>
      _NumberOfFilesThatDoesntExistLocallySheetState();
}

class _NumberOfFilesThatDoesntExistLocallySheetState
    extends ConsumerState<NumberOfFilesThatDoesntExistLocallySheet> {
  bool _closed = false;   
  bool _expanded = false; 

  late final int _images;
  late final int _videos;
  late final int _files;
  late final int _other; 
  late final int _totalSize;
  

  String totalMediaSizeParsing(int byte){
    if(byte >= 1024*1024*1024){
      return "${(byte/(1024*1024*1024)).toStringAsFixed(2)} gb (make sure u have enough storage)";
    } else if(byte >= 1024*1024){
      return "${(byte/(1024*1024)).toStringAsFixed(2)} mb";
    } else{
      return "${(byte/1024).toStringAsFixed(2)} kb";
    }

  }


  @override
  void initState() {
    super.initState();
    int images = 0, videos = 0, files = 0, other = 0 , totalsize = 0;
    for (final m in widget.media) {
      final type = m.filetype;
      totalsize += m.filesizeByte;
      if (mediaImageFormats.contains(type)) {
        images++;
      } else if (mediaVideoFormats.contains(type)) {
        videos++;
      } else if (mediaFileFormats.contains(type)) {
        files++;
      } else {
        other++;
      }
    }
    _images = images;
    _videos = videos;
    _files = files;
    _other = other;
    _totalSize = totalsize;
  }
   
    
  void _closeSheet() {
    if (_closed || !mounted) return;
    _closed = true;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final total = widget.media.length;

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
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '$total media missing on this device',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),

                  // counters
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CountTile(icon: Icons.image_outlined, label: 'Images', count: _images),
                      _CountTile(icon: Icons.videocam_outlined, label: 'Videos', count: _videos),
                      _CountTile(icon: Icons.insert_drive_file_outlined, label: 'Files', count: _files),
                    ],
                  ),
                  if (_other > 0) ...[
                    const SizedBox(height: 8),
                    Text(
                      '+ $_other other',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16,),
                  
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      "Total space needed : ${totalMediaSizeParsing(_totalSize)}"
                    ),

                  ),

                  const SizedBox(height: 16),

                  // note
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: scheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline_rounded, size: 20, color: scheme.primary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Make sure the secure connection is open on the other device, '
                            'and that both devices are connected to the same Wi-Fi network (or mobile data with hotspot).',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurface.withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                
                  Align(
                    alignment: Alignment.center,
                    child: TextButton.icon(
                      onPressed: () => setState(() => _expanded = !_expanded),
                      icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                      label: Text(_expanded ? 'Hide details' : 'Show details'),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: _expanded
                        ? ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 240),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: widget.media.length,
                              separatorBuilder: (_, _) => Divider(
                                height: 1,
                                color: scheme.onSurface.withValues(alpha: 0.08),
                              ),
                              itemBuilder: (context, i) {
                                final m = widget.media[i];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          m.filename,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: scheme.primary.withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child:Text(
  '.${m.filetype}',
  style: theme.textTheme.labelSmall?.copyWith(
    color: scheme.primary,
    fontWeight: FontWeight.w600,
  ),
),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : const SizedBox(width: double.infinity),
                  ),
                  const SizedBox(height: 12),

                 
                  FilledButton(
                    onPressed: () {
                      _closeSheet();
                      ScanQrCodeSheet.showSheet(widget.media);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Start'),
                    ),
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

class _CountTile extends StatelessWidget {
  const _CountTile({required this.icon, required this.label, required this.count});

  final IconData icon;
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Column(
      children: [
        Icon(icon, size: 28, color: scheme.primary),
        const SizedBox(height: 4),
        Text('$count', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}