import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/media_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/logger.dart';


/// To understand why we use this model for reading media from the cloud,
/// we need to understand the problem. We can't wire a snapshot listener to media
/// the way we did for a semester or a course. As explained in semester_provider.dart,
/// wiring a snapshot listener means Firestore reads every document in the collection
/// on attach. We can't do that for media: a user may have thousands of media items,
/// which would mean an enormous number of cloud reads (increasing billing) and heavy
/// CPU work on the user's phone (due to the echo-write problem also explained in that file).
///
/// Instead, we rely on two functions that do the same underlying work, just for
/// different situations:
/// - [syncMedia] runs when the user opens the app. We check the last media we wrote
///   locally and request anything missing from the cloud since then.
/// - [fetchAllMedia] runs when a new device connects to the account and has no media
///   for that account yet, so we want the entire collection.
/// Note that we don't care whether this is a fresh sign-in, a new device, or anything
/// else; we only care what the user currently has locally, and what's missing.
///
/// [lastTimeUpdatedDataFromTheCloud] is used as the reference point (a cursor) instead of
/// created_at, because we also need to catch updates: if a uuid already exists locally,
/// it means we should update it rather than insert it. This should be a variable that
/// persists on the device and updates every time we receive new media.
///
/// For deleting media: deletion only ever happens locally, on the device where the
/// delete was requested. We never delete the media from the cloud or from any other
/// device, to protect the user from losing their media. Any device that signs in later,
/// or already has the media locally, will still see it normally, even if it was deleted
/// on another device. Deletion is always scoped to the device it happened on.
///
/// Deleting a course or semester does not delete its media. Media always persists until
/// the user either deletes it manually from each linked device before deleting the
/// course/semester, or, after deleting a course/semester, goes to the "All Media" page
/// and deletes the now-orphaned media from there. This protects the user from losing
/// media permanently, especially since media bytes themselves are not cloud-synced.
///
/// If cross-device delete sync is ever needed in the future, add a "deletes" collection
/// under media that all devices listen to, and also add media deletion to the nested
/// delete flow (e.g. when a user deletes a semester or course, its nested media should
/// be deleted too).
/// 
/// A trade-off of this deletion model is that if a user accidentally adds the wrong
/// media to the wrong course, deleting it only removes it from the current device.
/// They would need to delete it again on every other linked device, and on any future
/// device connected to the account. As a future feature, we could introduce two delete
/// types: soft delete (removes it only from the current device, today's behavior) and
/// hard delete (removes it everywhere: the cloud and every synced device). for now
/// and for the very first version of the software , we will have only the soft delete feature


CollectionReference<Map<String, dynamic>> get docRef =>
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid) //using getter so if uid changed (user sign out then sign in) , docRef follow the new uid
        .collection('media');

class  MediaFirestore extends Notifier<void> implements MediaCloudDomain {
 

  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }


  @override
  Future<void> addNewMedia(MediaForm data) async {
    logger.i('adding new semester to firestore: $data');

    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await docRef.doc(data.uuid).set(data.toFirestore());
        logger.i('added semester to firestore successfully, uuid: ${data.uuid}');
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('user uid still not initialized');
    }
  }

  @override
  Future<List<MediaForm>?> fetchAllMedia() async {
    logger.i('fetching all media');
    if(FirebaseAuth.instance.currentUser != null){
      try{
        final rawDataCollection = await docRef.orderBy('created_at').orderBy(FieldPath.documentId).get();
        final rawData = rawDataCollection.docs;
        return rawData.map((rawMedia){
          return MediaForm.fromFirestore(rawMedia.data(), rawMedia.id);
        }).toList();

      } catch(e){
        logger.e(e);
        return null;
      }
      
    } else{
      logger.e('user uid still not initialized');
      return null;
    }
   
  }

  @override
  Future<List<MediaForm>?> syncMedia(String lastUUIDmediaInsertedLocally, DateTime lastTimeUpdatedDataFromTheCloud) async {
    logger.i('fetching missing media');
    if(FirebaseAuth.instance.currentUser != null){
      try{
        final rawDataCollection = await docRef
    .orderBy('updated_at')
    .orderBy(FieldPath.documentId)
    .startAfter([lastTimeUpdatedDataFromTheCloud, lastUUIDmediaInsertedLocally])
    .get();

    final rawData = rawDataCollection.docs;
        return rawData.map((rawMedia){
          return MediaForm.fromFirestore(rawMedia.data(), rawMedia.id);
        }).toList();                              

      }catch(e){
        logger.e(e);
        return null;
      }

    } else{
      logger.e('user uid still not initialized');
      return null;
    }

    
   
  }

  @override
  Future<void> updateMedia(MediaForm data) async {
    logger.i('updating semester in firestore: $data');

    if (FirebaseAuth.instance.currentUser != null) {
      try {
        await docRef.doc(data.uuid).update(data.toFirestore());
        logger.i('updated semester in firestore successfully, uuid: ${data.uuid}');
      } catch (e) {
        logger.e(e);
        rethrow;
      }
    } else {
      logger.e('user uid still not initialized');
    }
  
  }


}