# flutterfrontenduniprojectmanager

A new Flutter project , the frontend for "Campus Local" project , built for Lebanese university students. Free and open-source, with a fast and interactive UI. A local-first application to manage students' semesters, courses, media (videos, images, files), deadlines, and calendars, synced with an external database.

## Quick Notes

The project architecture is local-first: the app is designed to manage a student's university life fully offline, with the local database as the source of truth. The parts we sync to the external DB are: deadlines, user data, courses, semesters, and media metadata.

### Sync strategy

Since the app works offline-first across multiple devices, we don't rely on a single global "last edited" timestamp. Instead, every mutation is recorded in a `changes` log table (per user, per table, per row, with a timestamp). Each device keeps track of its own `last_synced` timestamp , the newest change it has pulled , and asks the server for anything newer whenever it comes online (app open, manual refresh, or connectivity change). Conflicting edits on the same row are resolved with last-write-wins, compared by the change's own timestamp, not by which device synced first. Old, fully synced changes are periodically cleaned up based on the slowest still active device's sync position.

### Media handling

On the media side, we only store the logical path (e.g. `/semester1/m1101/{media_id}`) of a given media file in the DB — the actual file lives in a local folder external to the app's sandboxed storage, on the device itself. **There is no real media file syncing to the server DB** , media metadata syncs like any other table, but the file bytes never touch the server.

For multi-device support, the app relies on direct device-to-device transfer over the same LAN/WiFi network: the device holding the file starts a local HTTPS server (self-signed certificate) and advertises itself via mDNS (multicast DNS); the device missing the file discovers it, pairs using a one-time-session PIN, and requests the missing files individually over HTTPS. Never rely on the application as the "cloud storage" , it is local-first and device-synced only.

> To understand the full sync and media-transfer design (diagrams, edge cases, and reasoning) , and data base tables, For developers ,download the file : **uniProjectDB.drawio** in the existing repo , and open it via draw.io 


