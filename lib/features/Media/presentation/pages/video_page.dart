// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/favorite_filter.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/imageAppbar.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/video_app_bar.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/VideoService/media_video_service.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';
import 'package:flutterfrontenduniprojectmanager/router/routes_data.dart';
import 'package:go_router/go_router.dart';

class VideoPage extends ConsumerStatefulWidget {
  const VideoPage({super.key,required this.courseData});
   final Course courseData;

  @override
  ConsumerState<VideoPage> createState() {
    return _VideoPageState();
  }

}

class _VideoPageState extends ConsumerState<VideoPage>{
  final allowedFormat =  ['mp4', 'mov' , 'mkv' , 'avi'];
  final _scrollController = ScrollController();
  bool _loadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    ref.read(mediaServiceProvider.notifier).readData(widget.courseData.uuid!, allowedFormat);
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
       print("loading more..");
      final before = ref.read(mediaProvider)?.length ?? 0;

      await ref
          .read(mediaServiceProvider.notifier)
          .readData(widget.courseData.uuid!, allowedFormat);

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
          if (didPop) {ref.read(mediaProvider.notifier).resetMediaState();ref.read(currentFavStateProvider.notifier).resetToFalse();}
        },
        child: CustomScrollView(
          controller: _scrollController,       
          slivers: [
            VideoAppBar(courseDetails: widget.courseData),
            _VideoGridBody()           
          ],
        ),
      ),
    );
    
  }
}


///NOTE : when a user add a video , we may not see a thumbnail at first
///because we trade this with faster video adding(generating thumbnail take time)

class _VideoGridBody extends ConsumerWidget {
  const _VideoGridBody();

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
              Icon(Icons.videocam_off_outlined, size: 48, color: scheme.outline),
              const SizedBox(height: 12),
              Text(
                'No videos yet',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap the + button to add a video to this course.',
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
          childAspectRatio: 0.8, // taller than wide: thumbnail on top + name bar below
        ),
        itemCount: mediaList.length,
        itemBuilder: (context, index) {
          final media = mediaList[index];
          return VideoTile(mediaItem: media, key: ValueKey(media.uuid ?? media.id));
        },
      ),
    );
  }
}

class VideoTile extends ConsumerStatefulWidget {
  const VideoTile({super.key, required this.mediaItem});

  final MediaForm mediaItem;

  @override
  ConsumerState<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends ConsumerState<VideoTile> {
  late final MediaVideoService _service;

  Uint8List? byte;

  String? explicitPath;

  @override
  void initState() {
    super.initState();
    _service = ref.read(mediaVideopServiceProvider.notifier);
    Future.microtask(() async{
       await _load();
    });
   
  }

  @override
  void didUpdateWidget(VideoTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mediaItem.uuid != widget.mediaItem.uuid) {
      if (oldWidget.mediaItem.uuid != null) {
        _service.markInvisibleVIDEOthumbnail(oldWidget.mediaItem.uuid!);
      }
      byte = null;
      Future.microtask(() async{
       await _load();
    });
    }
  }

  Future<void> _load() async {
    explicitPath = await ref.read(mediaVideopServiceProvider.notifier).returnVideoExplicitePath(widget.mediaItem.filepath);
    final uuid = widget.mediaItem.uuid;
    if (uuid == null) return;

    final result = await _service.returnVIDEOthumbnail(uuid);

    if (!mounted || widget.mediaItem.uuid != uuid) return;
    setState(() => byte = result);
  }

  @override
  void dispose() {
    final uuid = widget.mediaItem.uuid;
    if (uuid != null) _service.markInvisibleVIDEOthumbnail(uuid);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final media = widget.mediaItem;

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
        onTap: () {

          context.push('/home/courses/${widget.mediaItem.courseUuid}/videos/video/${widget.mediaItem.uuid}' , 
          extra: VideoRouteData(explicitPath: explicitPath, videoDetails: widget.mediaItem));
        },
        child: Column(
          children: [
           
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  byte == null
                      ? Center(
                          child: Icon(
                            Icons.movie_rounded,
                            size: 32,
                            color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
                          ),
                        )
                      : Image.memory(
                          byte!,
                          fit: BoxFit.cover,
                          cacheWidth: 300,
                          gaplessPlayback: true,
                        ),
                  Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      size: 44,
                      color: Colors.white.withValues(alpha: 0.8),
                      shadows: const [
                        Shadow(blurRadius: 8, color: Colors.black54),
                      ],
                    ),
                  ),
                ],
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
                '${media.filename}.${media.filetype}',
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