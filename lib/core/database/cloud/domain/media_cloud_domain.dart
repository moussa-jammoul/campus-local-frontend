import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';

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
/// and the first version of the software , we will have only soft delete
abstract class MediaCloudDomain {

  Future<void> addNewMedia(MediaForm data);
  Future<void> updateMedia(MediaForm data);
  Future<List<MediaForm>?> syncMedia(String lastUUIDmediaInsertedLocally , DateTime lastTimeUpdatedDataFromTheCloud);
  Future<List<MediaForm>?> fetchAllMedia();


}