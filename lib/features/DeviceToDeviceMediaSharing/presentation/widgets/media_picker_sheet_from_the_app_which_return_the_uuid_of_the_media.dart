import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/cache/cache_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/media_management.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/ImageService/media_image_service.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/VideoService/media_video_service.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';
import 'package:path/path.dart' as p;
import 'dart:typed_data';

class MediaPickerSheetFromTheAppWhichReturnTheuuidOfTheMedia extends StatelessWidget {
  const MediaPickerSheetFromTheAppWhichReturnTheuuidOfTheMedia({super.key});

  Future<void> _onPick(BuildContext context, MediaForm media) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Choose this media?'),
        content: Text('${media.filename}.${media.filetype}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Choose'),
          ),
        ],
      ),
    );

    
    if (confirmed != true || !context.mounted) return;

    Navigator.of(context).pop(media.uuid!); 
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            Text(
              'Choose a media',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: MediaPickerGrid(onPick: (media) => _onPick(context, media)),
            ),
          ],
        ),
      ),
    );
  }
}





class MediaPickerGrid extends ConsumerStatefulWidget {
  const MediaPickerGrid({super.key, required this.onPick});

  final void Function(MediaForm media) onPick;

  @override
  ConsumerState<MediaPickerGrid> createState() => _MediaPickerGridState();
}

class _MediaPickerGridState extends ConsumerState<MediaPickerGrid> {
  final _scrollController = ScrollController();
  bool _loadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.read(mediaServiceProvider.notifier).readData(null, null);
    });
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

      await ref.read(mediaServiceProvider.notifier).readData(null, null);

      if (!mounted) return;
      final after = ref.read(mediaProvider)?.length ?? 0;
      if (after == before) _hasMore = false;
    } finally {
      _loadingMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<MediaForm>? mediaList = ref.watch(mediaProvider);

    if (mediaList == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (mediaList.isEmpty) {
      return const Center(child: Text('No media'));
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8, 
      ),
      itemCount: mediaList.length,
      itemBuilder: (context, i) {
        final media = mediaList[i];
        return _PickerTile(
          key: ValueKey(media.id),
          media: media,
          onTap: () => widget.onPick(media),
        );
      },
    );
  }
}



class _PickerTile extends StatelessWidget {
  const _PickerTile({super.key, required this.media, required this.onTap});

  final MediaForm media;
  final VoidCallback onTap;

  Widget _preview() {
    if (mediaFileFormats.contains(media.filetype)) {
      return _FilePreview(type: media.filetype);
    } else if (mediaImageFormats.contains(media.filetype)) {
      return _ImagePreview(media: media);
    } else {
      return _VideoPreview(media: media);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _preview(),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            media.filename,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}


class _IconBox extends StatelessWidget {
  const _IconBox({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      color: scheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(icon, size: 36, color: scheme.primary),
    );
  }
}

class _FilePreview extends StatelessWidget {
  const _FilePreview({required this.type});
  final String type;

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

  @override
  Widget build(BuildContext context) => _IconBox(icon: _iconFor(type));
}



class _ImagePreview extends ConsumerStatefulWidget {
  const _ImagePreview({required this.media});
  final MediaForm media;

  @override
  ConsumerState<_ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends ConsumerState<_ImagePreview> {
  late final CacheManagment _cache;
  Uint8List? byte;

  @override
  void initState() {
    super.initState();
    _cache = ref.read(cacheManagmentProvider);
    _load();
  }

  @override
  void didUpdateWidget(_ImagePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.media.id != widget.media.id) {
      if (oldWidget.media.id != null) {
        _cache.markInvisible(oldWidget.media.id!);
      }
      byte = null;
      _load();
    }
  }

  Future<void> _load() async {
    final m = widget.media;
    final id = m.id;
    if (id == null) return;

    final relativePath = p.join(
      'user', m.userUid, 'course', m.courseUuid, 'media', '${m.uuid!}.${m.filetype}',
    );
    final result = await _cache.cacheImage(id, relativePath);

    // the tile may be disposed, or reused for another media, while we waited
    if (!mounted || widget.media.id != id) return;
    setState(() => byte = result);
  }

  @override
  void dispose() {
    final id = widget.media.id;
    if (id != null) _cache.markInvisible(id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final existsLocally = widget.media.mediaExistLocally ?? true;

    if (byte == null || !existsLocally) {
      return const _IconBox(icon: Icons.image_rounded);
    }
    return Image.memory(
      byte!,
      fit: BoxFit.cover,
      cacheWidth: 300,
      gaplessPlayback: true,
    );
  }
}

class _VideoPreview extends ConsumerStatefulWidget {
  const _VideoPreview({required this.media});
  final MediaForm media;

  @override
  ConsumerState<_VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends ConsumerState<_VideoPreview> {
  late final CacheManagment _cache;
  Uint8List? byte;

  @override
  void initState() {
    super.initState();
    _cache = ref.read(cacheManagmentProvider);
    _load();
  }

  @override
  void didUpdateWidget(_VideoPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.media.uuid != widget.media.uuid) {
      if (oldWidget.media.uuid != null) {
        _cache.markThumbnailInvisible(oldWidget.media.uuid!);
      }
      byte = null;
      _load();
    }
  }

  Future<void> _load() async {
    final uuid = widget.media.uuid;
    if (uuid == null) return;

    final result = await _cache.cacheThumbnail(uuid);

    if (!mounted || widget.media.uuid != uuid) return;
    setState(() => byte = result);
  }

  @override
  void dispose() {
    final uuid = widget.media.uuid;
    if (uuid != null) _cache.markThumbnailInvisible(uuid);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final existsLocally = widget.media.mediaExistLocally ?? true;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (byte == null || !existsLocally)
          const _IconBox(icon: Icons.videocam_outlined)
        else
          Image.memory(
            byte!,
            fit: BoxFit.cover,
            cacheWidth: 300,
            gaplessPlayback: true,
          ),
        // play box in the middle
        Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.55),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }
}