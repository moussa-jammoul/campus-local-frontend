# Campus Local

A new Flutter project — the frontend for the "Campus Local" project, built for Lebanese university students. Free and open-source, with a fast and interactive UI. A local-first application to manage students' semesters, courses, media (videos, images, files), deadlines, and calendars, synced with the Firestore cloud service.

## Quick Notes

The project architecture is local-first: the app is designed to manage a student's university life fully offline (aside from logging in), with the local database as the source of truth. The parts we sync to the external cloud are: deadlines, user data, courses, semesters, and media metadata (not the media itself).

### Sync strategy

Since the app works offline-first across multiple devices, it's worth understanding how Firestore supports this approach.

Firestore automatically maintains an offline cache of the user's data, so functions like `.get()` don't fail without a connection , they simply read from the cache instead (note that we still maintain our own local source-of-truth database, so we don't lose the power of a proper SQL database for this kind of project). Write functions like `.set()`, `.update()`, and others are automatically queued while offline, and synced to the Firestore cloud as soon as connectivity returns , no manual handling required. On top of this, listening to Firestore's live snapshots also falls back to the local cache while offline, and automatically syncs the local DB with any new changes from the cloud once connectivity is restored.

Note: the project is flexible enough to swap Firestore for a different cloud database if you'd prefer. If you do, you'll need to build your own queued-task management system to handle syncing changes to your chosen backend, since that part is currently provided by Firestore itself.

### Media handling

On the media side, we only store the logical path (e.g. `/semester1/m1101/{media_id}`) of a given media file in the DB , the actual file lives in a local folder external to the app's sandboxed storage, on the device itself. **There is no real media file syncing to the server DB** , media metadata syncs like any other table, but the file bytes never touch the server.

For multi-device support, the app relies on direct device-to-device transfer over the same LAN/WiFi network: the device holding the file starts a local HTTPS server (self-signed certificate) and advertises itself via mDNS (multicast DNS); the device missing the file discovers it, pairs using a one-time-session PIN, and requests the missing files individually over HTTPS. Never rely on the application as "cloud storage" , it is local-first and device-synced only.


## For developers

### Setup

1. Clone the repo.
2. Run `flutter pub get`.
3. Set up your own Firebase project, and add your config files and Firestore security rules.
4. Run the app , platform plugin files will be generated automatically on first run.

> To understand the full sync and media-transfer design (diagrams, edge cases, and reasoning), and the database tables, developers can download **uniProjectDB.drawio** (not ready yet) from the repo and open it via draw.io.
