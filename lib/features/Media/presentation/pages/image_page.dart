
// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/appbar.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/ImageService/media_image_service.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';
import 'package:flutterfrontenduniprojectmanager/router/routes_data.dart';
import 'package:go_router/go_router.dart';

class ImagePage extends ConsumerStatefulWidget {
  
  const ImagePage({super.key, required this.courseData});
  
  final Course courseData;

  @override
  ConsumerState<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends ConsumerState<ImagePage> {
  final _scrollController = ScrollController();
  bool _loadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    ref.read(mediaServiceProvider.notifier).readData(widget.courseData.uuid!, ['png', 'jpg']);
  }

  @override
  void dispose() {
    _scrollController.dispose();   // disposing it also drops the listener
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
          .readData(widget.courseData.uuid!, ['png', 'jpg']);

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
            ImageAppBar(courseDetails: widget.courseData),
            _ImageGridBody(),             
          ],
        ),
      ),
    );
  }
}



class _ImageGridBody extends ConsumerWidget {

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
              Icon(Icons.image_not_supported_outlined,
                  size: 48, color: scheme.outline),
              const SizedBox(height: 12),
              Text(
                'No images yet',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap the + button to add media to this course.',
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
          childAspectRatio: 1, // Keeps tiles square
        ),
        itemCount: mediaList.length,
        
        itemBuilder: (context, index) {
          final media = mediaList[index];
          return ImageTile(mediaItem: media ,  key: ValueKey(media.id), );
        },
      ),
    );
  }
}

class ImageTile extends ConsumerStatefulWidget {
  const ImageTile({super.key, required this.mediaItem});

  final MediaForm mediaItem;

  @override
  ConsumerState<ImageTile> createState() => _ImageTileState();
}

class _ImageTileState extends ConsumerState<ImageTile> {
  late final MediaImageService _service;

  Uint8List? byte;
  @override
  void initState() {
    super.initState();
    _service = ref.read(mediaImageServiceProvider.notifier); 
    _load();
  }


  @override
  void didUpdateWidget(ImageTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mediaItem.id != widget.mediaItem.id) {
      if (oldWidget.mediaItem.id != null) {
        _service.markInvisibleImage(oldWidget.mediaItem.id!);
      }
      byte = null;
      _load();
    }
  }

  Future<void> _load() async {
    final id = widget.mediaItem.id;
    if (id == null) return;

    final result = await _service.returnMediaImage(id);

  
    if (!mounted || widget.mediaItem.id != id) return;
    setState(() => byte = result);
  }

  @override
  void dispose() {
    final id = widget.mediaItem.id;
    if (id != null) _service.markInvisibleImage(id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child:
       GestureDetector(
        onTap: () {
          context.push('/home/courses/${widget.mediaItem.courseUuid}/images/image/${widget.mediaItem.uuid}' , 
          extra: ImageRouteData(bytes: byte, imageDetail: widget.mediaItem)
          );
        },
        child:
       byte == null ? Center(
        child: Icon(
          Icons.image_rounded,
          size: 32,
          color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
        ),
      
      ) 
      : 
     
      Image.memory(
  byte!,
  fit: BoxFit.cover,
  cacheWidth: 300,         
  gaplessPlayback: true,    
)
       )
      
    );
  }
}