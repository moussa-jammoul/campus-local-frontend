import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/cache/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/media_management.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;

///cache managment cache images and videos thumbnail , with a max limit for each,
///(note that this message i write it assuming that we still use flutter gird tiles ui , to render the images) 
///when i tile born  , from init we call cache image , which check following stuff
///if the image already cached , return directly the image , if note , read the sandboxed storage
///get the image , cache it, then return it  , we check before if we hit the max allowed cached images.
///when a tile dispose (flutter grid handle disposing when it is not anymore visible to the screen with a margin outside the screen)
///we don't remove the image cache , we just mark that the current image is not anymore visible to the ui , when we cache new image
///and we hit the max , we keep looping removing the oldest cached images until we are under the max , then we cache the new image

class CacheManagment{
  
  CacheManagment({
    required this.ref
  }) {
    logger = ref.read(loggerProvider);
  }
  Ref ref;

  MediaImageCache imageCaches = {};
  MediaVideoThumbnailCache thumbnailsCaches = {}; 
  
  ///used to detect what curret image is not visible , when we
  ///reach to max caches , we start checking / removing from the oldest 
  List<int> currentInvisibleImageCachedId = [];
  List<String> currentInvisibleImageIdThumbnailCachedUuid = [];


  final int maxCacheImages = 60;
  
  final int maxCacheThumbnails = 45;

  late Logger logger;
  
  
  

  ///ui (grid tile) when init ,will call this function , if the media is cached or yet
  ///then we assume that it exist , if we get that it didn't exist  we load a broken image
  Future<Uint8List?> cacheImage(
    int id,
    String relativePath
    ) async{
    try {
      _markVisible(id);
      if(imageCaches.containsKey(id)){
        return imageCaches[id];
        //no need to cache , already exist
      } else{
        final byte = await ref.read(mediaManagmentProvider.notifier).readMediaBytes(
          relativePath
        ); 
        if (byte != null) {
          imageCaches[id] = byte;
          while (imageCaches.length > maxCacheImages &&
             currentInvisibleImageCachedId.isNotEmpty) {
            _removeCachedImage();
          }
          logger.i('Image cached: $id (total: ${imageCaches.length})');
          return byte;
        } 
        logger.w('Image not found, nothing cached: $relativePath');
        return null;

      }
    } catch (e, st) {
      logger.e('Failed to cache image $id', error: e, stackTrace: st);
      return null;
    }

  }
  
  ///removing the oldest non visible cached image
  void _removeCachedImage() {
    if(currentInvisibleImageCachedId.isNotEmpty){
      final id = currentInvisibleImageCachedId[0];
      if(imageCaches.containsKey(id)){
      imageCaches.remove(id);
      
      }
      currentInvisibleImageCachedId.removeAt(0);
    }
    

  }
  

  ///used when a ui (grid tile) dispose , it call this
  void markInvisible(int id) {
    if(!currentInvisibleImageCachedId.contains(id)){
    currentInvisibleImageCachedId.add(id);
    }
  }
  
  ///we don't need to call mark visible in the ui itself , because 
  ///the ui when it is visible it call by itself the cache image , which call it as a visible.
  void _markVisible(int id) {
    if(currentInvisibleImageCachedId.contains(id)){
    currentInvisibleImageCachedId.remove(id);
    }
  }

    ///ui (video grid tile) calls this when it inits. Same rules as images:
  ///visible thumbnails are pinned, the oldest invisible one is removed at the max.
  Future<Uint8List?> cacheThumbnail(String mediaUuid) async {
    try {
      _markThumbnailVisible(mediaUuid);

      if (thumbnailsCaches.containsKey(mediaUuid)) {
        return thumbnailsCaches[mediaUuid];
      } else {
        final byte = await ref
            .read(mediaManagmentProvider.notifier)
            .readMediaByteVideoThumbnail(mediaUuid);

        if (byte != null) {
          thumbnailsCaches[mediaUuid] = byte;
          while (thumbnailsCaches.length > maxCacheThumbnails &&
              currentInvisibleImageIdThumbnailCachedUuid.isNotEmpty) {
            _removeCachedThumbnail();
          }
          logger.i('Thumbnail cached: $mediaUuid (total: ${thumbnailsCaches.length})');
          return byte;
        }
        // null is not cached on purpose: the thumbnail is generated in the
        // background, so it may not exist yet. The next request will retry.
        logger.w('Thumbnail not found, nothing cached: $mediaUuid');
        return null;
      }
    } catch (e, st) {
      logger.e('Failed to cache thumbnail $mediaUuid', error: e, stackTrace: st);
      return null;
    }
  }

  ///removing the oldest non visible cached thumbnail
  void _removeCachedThumbnail() {
    if (currentInvisibleImageIdThumbnailCachedUuid.isNotEmpty) {
      final uuid = currentInvisibleImageIdThumbnailCachedUuid[0];
      thumbnailsCaches.remove(uuid);
      currentInvisibleImageIdThumbnailCachedUuid.removeAt(0);
    }
  }

  ///used when a video tile disposes
  void markThumbnailInvisible(String mediaUuid) {
    if (!currentInvisibleImageIdThumbnailCachedUuid.contains(mediaUuid)) {
      currentInvisibleImageIdThumbnailCachedUuid.add(mediaUuid);
    }
  }

  ///called by cacheThumbnail itself, the ui doesn't need to call it
  void _markThumbnailVisible(String mediaUuid) {
    currentInvisibleImageIdThumbnailCachedUuid.remove(mediaUuid);
  }

}

final cacheManagmentProvider = Provider((ref){
  return CacheManagment(ref: ref);
});