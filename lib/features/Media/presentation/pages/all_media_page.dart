import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/media_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/pages/file_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/pages/image_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/pages/video_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/widgets/favorite_filter.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/media_services.dart';

import 'dart:ui';

import 'package:go_router/go_router.dart';







class AllMediaPage extends ConsumerStatefulWidget {
  const AllMediaPage({super.key});

  @override
  ConsumerState<AllMediaPage> createState() => _AllMediaPageState();
}

class _AllMediaPageState extends ConsumerState<AllMediaPage> {

 

  final _scrollController = ScrollController();
  bool _loadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    ref.read(mediaServiceProvider.notifier).readData(null,null);
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
          .readData(null,null);

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
  
    final List<MediaForm>? mediaList = ref.watch(mediaProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
        FavoritesButton(),
        IconButton(
          onPressed: () {
            unawaited(
              ref
                  .read(mediaServiceProvider.notifier)
                  .fetchCloudData(),
            );
          },
          icon: const Icon(Icons.refresh),
        ),
        const SizedBox(width: 12),
      ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('All Media'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              decoration: BoxDecoration(
                color: scheme.surface.withValues(alpha: 0.25),
                border: Border(
                  bottom: BorderSide(
                    color: scheme.onSurface.withValues(alpha: 0.08),
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body:PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop){ 
            ref.read(mediaProvider.notifier).resetMediaState();
            ref.read(currentFavStateProvider.notifier).resetToFalse();
            }
        },
        child: _buildBody(mediaList, scheme),
      )
    );
  }

  Widget _buildBody(List<MediaForm>? mediaList, ColorScheme scheme) {
    if (mediaList == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (mediaList.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.perm_media_outlined,
              size: 64,
              color: scheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 12),
            Text(
              'No Media yet'
              ,
              
              style: TextStyle(
                color: scheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
       
        SliverPadding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + 8,
            left: 8,
            right: 8,
            bottom: 8,
          ),
          sliver: SliverGrid(
            
            gridDelegate: const  SliverGridDelegateWithMaxCrossAxisExtent(
            
              maxCrossAxisExtent: 140,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1, 
             
            ),
            delegate: SliverChildBuilderDelegate(
              
              
              (context, index) => decideTile(mediaList[index]),
              childCount: mediaList.length,
            ),
          ),
        ),
      ],
    );
  }


  ///this function is used to return a specific tile 
  ///depending on the type of the media
  Widget decideTile(MediaForm media){
    if(mediaFileFormats.contains(media.filetype)){
      return FileTile(mediaItem: media ,  key: ValueKey(media.id));
    }
    else if(mediaImageFormats.contains(media.filetype)){
      return ImageTile(mediaItem: media,  key: ValueKey(media.id));
    } else{
      return VideoTile(mediaItem: media,  key: ValueKey(media.id));
    }
  }
}


