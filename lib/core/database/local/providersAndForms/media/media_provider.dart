import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_media.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
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

  Future<void> deleteMedia(int id) async {
    logger.i('deleting media, id: $id');
    try {
      await ref.read(writeMediaProvider.notifier).deleteData(id);
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
      logger.i('updated media successfully, uuid: ${data.uuid}');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<void> loadPaginatedMediaForACourse(String userUid, String courseUuid, int limit) async {
    logger.i('loading paginated media for courseUuid: $courseUuid, alreadyRead: $alreadyRead, limit: $limit');
    try {
      final data = await ref.read(writeMediaProvider.notifier).readData(userUid, courseUuid, limit, alreadyRead);
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

  Future<void> addNewMedia(String userUid, String courseUuid, MediaForm media) async {
    logger.i('adding new media for the course : $courseUuid');
    try {
      final inserted = await ref.read(writeMediaProvider.notifier).addData(media);

      ///here , we can't assume that the user still in the page to actually render the new media
      ///because we are here after an asyn , so we can make a quick check by using the current position
      ///of the user
      ///
      if (getCurrentLocation(ref: ref)?.startsWith('/home/courses/$courseUuid') ?? false) {
        if (state == null) {
          state = [inserted];
        } else {
          state = [inserted, ...state!];
        }
      }
      logger.i('added media successfully, uuid: ${inserted.uuid}');
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
