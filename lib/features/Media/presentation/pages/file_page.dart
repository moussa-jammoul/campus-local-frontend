import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/file_app_bar.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/media_detail_sheet.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/FileService/media_file_service.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';
import 'package:open_filex/open_filex.dart';


const allowedFileFormat = ['pdf', 'doc', 'docx', 'ppt', 'pptx', 'xls', 'xlsx', 'txt', 'zip'];

class FilePage extends ConsumerStatefulWidget {
  const FilePage({super.key, required this.courseData});

  final Course courseData;

  @override
  ConsumerState<FilePage> createState() => _FilePageState();
}

class _FilePageState extends ConsumerState<FilePage> {
  final _scrollController = ScrollController();
  bool _loadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    ref.read(mediaServiceProvider.notifier).readData(widget.courseData.uuid!, allowedFileFormat);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 100) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMore) return;
    _loadingMore = true;
    try {
      final before = ref.read(mediaProvider)?.length ?? 0;

      await ref
          .read(mediaServiceProvider.notifier)
          .readData(widget.courseData.uuid!, allowedFileFormat);

      if (!mounted) return;
      final after = ref.read(mediaProvider)?.length ?? 0;
      if (after == before) _hasMore = false;
    } finally {
      _loadingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      body: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) ref.read(mediaProvider.notifier).resetMediaState();
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            FileAppBar(courseDetails: widget.courseData),
            const _FileGridBody(),
          ],
        ),
      ),
    );
  }
}

class _FileGridBody extends ConsumerWidget {
  const _FileGridBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaList = ref.watch(mediaProvider);
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (mediaList == null) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator(strokeWidth: 2.5)),
      );
    }

    if (mediaList.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.folder_off_outlined, size: 48, color: scheme.outline),
              const SizedBox(height: 12),
              Text(
                'No files yet',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap the + button to add a file to this course.',
                style: textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 140,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,   
        ),
        itemCount: mediaList.length,
        itemBuilder: (context, index) {
          final media = mediaList[index];
          return FileTile(mediaItem: media, key: ValueKey(media.uuid ?? media.id));
        },
      ),
    );
  }
}

class FileTile extends ConsumerWidget {
  const FileTile({super.key, required this.mediaItem});
  
  final MediaForm mediaItem;

  IconData _iconFor(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'doc':
      case 'docx':
        return Icons.description_rounded;
      case 'xls':
      case 'xlsx':
      case 'csv':
        return Icons.table_chart_rounded;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow_rounded;
      case 'zip':
      case 'rar':
      case '7z':
        return Icons.folder_zip_rounded;
      case 'txt':
        return Icons.article_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Future<void> openfile(WidgetRef ref, BuildContext context) async {
  final path = await ref
      .read(mediaFileServiceProvider.notifier)
      .grabExplicitPath(mediaItem.filepath);

  
  if (!context.mounted) return;

  if (path == null) {
    _showMessage(
      context,
      'The file does not exist locally, please make sure to run '
      '"Fetch Unavailable Media" inside the setting to get any missing media',
    );
    return;
  }

  final result = await ref
      .read(mediaFileServiceProvider.notifier)
      .openFileViaExternalApp(path);

  if (!context.mounted) return;

  if (result.type != ResultType.done) {
    final message = switch (result.type) {
      ResultType.noAppToOpen => 'No app found that can open this file',
      ResultType.fileNotFound => 'The file was not found on this device',
      ResultType.permissionDenied => 'Permission denied while opening the file',
      _ => 'Could not open the file',
    };
    _showMessage(context, message);
  }
}

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()         
    ..showSnackBar(SnackBar(content: Text(message) ,duration: Duration(seconds: 3),));
}

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
 
    return Container(
     
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: GestureDetector(
        onLongPress: () {
          unawaited(
          MediaDetailSheet.show(context, mediaItem)
          );
        },
        onTap: ()  {
          unawaited(openfile(ref , context));  
        },
        child: Column(
          children: [
            
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _iconFor(mediaItem.filetype),
                      size: 40,
                      color: scheme.primary.withValues(alpha: 0.8),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      mediaItem.filetype.toUpperCase(),
                      style: textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          
            Container(
              width: double.infinity,
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh.withValues(alpha: 0.9),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Text(
                '${mediaItem.filename}.${mediaItem.filetype}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}