import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_media.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/storage/media/media_management.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:logger/web.dart';



///media provider hold the current media that should be rendered , in a current page

class MediaProvider extends Notifier<List<MediaForm>?> {

  int alreadyRead = 0;
  late Logger logger;

  @override
  List<MediaForm>? build() {
    logger = ref.read(loggerProvider);
    return null;
  }
  
  ///NOTE : id used to delete the meta data of the image locally , deleting 
  ///the media itself (the file) we call another function we call it in the service side
  Future<void> deleteMedia(int id) async {
    logger.i('deleting media, id: $id');
    try {
      await ref.read(writeMediaProvider.notifier).deleteData(id);

     final current = state;
     if (current != null) {
        state = current.where((m) => m.id != id).toList();
     }
      logger.i('deleted media successfully, id: $id');
    } catch (e) { 
      logger.e(e);
      rethrow;
    }
  }

  Future<void> updateMedia(MediaForm data) async {
    logger.i('updating media: $data');
    try {
      await ref.read(writeMediaProvider.notifier).updateData(data);
       final current = state;
       if (current != null) {
      state = [
        for (final m in current) m.uuid == data.uuid ? data : m,
      ];
      }
      logger.i('updated media successfully, uuid: ${data.uuid}');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> loadPaginatedMediaForACourse(String userUid, String courseUuid, int limit , List<String>? fileextention) async {
    logger.i('loading paginated media for courseUuid: $courseUuid, alreadyRead: $alreadyRead, limit: $limit');
    try {
      final data = await ref.read(writeMediaProvider.notifier).readData(userUid, courseUuid, limit, alreadyRead , fileextention);
      if (data != null && state != null) {
        state = [...state!, ...data];
      } else {
        state = data;
      }
      alreadyRead += data?.length ?? 0;
      logger.i('loaded ${data?.length ?? 0} media items for courseUuid: $courseUuid');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  ///reset media state used to reset the current stat of this provider ( make it null), and
  ///reset the already read integer , so when we load another pagination of media it read the correct
  ///order , so it doesn't miss any media at first
  void resetMediaState() {
    logger.i('resetting media state');
    state = null;
    alreadyRead = 0;
  }
  

  ///used for adding a single media
  Future<MediaForm> addNewMedia( MediaForm media) async {
    logger.i('adding new media for the course : ${media.courseUuid}');
    try {
      final inserted = await ref.read(writeMediaProvider.notifier).addData(media);

      ///here , we can't assume that the user still in the page to actually render the new media
      ///because we are here after an asyn , so we can make a quick check by using the current position
      ///of the user
      
      logger.i("checking if user still at the target page");
      logger.i(getCurrentLocation(ref: ref));
      if (getCurrentLocation(ref: ref)?.startsWith('/home/courses/${media.courseUuid}') ?? false ) {
        logger.i("user still inside the page to add the image in the state");
        
        if (state == null) {
          state = [inserted];
        } else {
          state = [inserted, ...state!];
        }
      }
      
      logger.i('added media successfully, uuid: ${inserted.uuid}');
        return inserted;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
  
  ///for performence and optimization , we split one for adding a list of media , whenever it was called from fetching cloud
  ///media or a future feature to add  multiple media with the same picker , to prevent rebuilding state 
  ///each time  , e.g let's say we fetch 200 media , looping and calling add new media will overload the cpu
  ///because rebuilding the state list each time until we end (because state is immutable) , here we just call directly 
  ///state = [...state , ...list] , one rebuild , note that add list media don't touch state , so to update the state
  ///we should call reset media state first , then loading paginated data
  Future<void> addListOfMedia(List<MediaForm> data) async{
    logger.i('adding list of media for the course');
    try{
      List<MediaForm> insertedData = [];
      for(final media in data ){
        final existing = media.uuid == null
            ? null
            : await ref.read(writeMediaProvider.notifier).findByUuid(media.uuid!);

        if (existing != null) {
          ///already exist locally, so it is an update (not added to insertedData)
          await updateMedia(media);
        } else {
          final inserted = await ref.read(writeMediaProvider.notifier).addData(media);
          insertedData.add(inserted);
        }
      }
    
      logger.i('added list of media successfully');


    } catch(e){
      logger.e(e);
      rethrow;
    }
  }
}


final mediaProvider = NotifierProvider<MediaProvider,List<MediaForm>?>((){
  return MediaProvider();
});