# System Architecture & Engineering Decisions

> **Required Notice:** Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)  
> Licensed under the [PolyForm Noncommercial License 1.0.0](LICENSE.md).

---

## 1. High-Level Architectural Overview

**Campus Local** is a **local-first, multi-device academic and media management application** built with Flutter, Riverpod, SQLite, Firebase (Auth, Firestore, FCM), and an embedded local HTTPS server for peer-to-peer media transfer.

The codebase follows a **Hybrid Core + Feature-First Layered Architecture**:

```text
lib/
├── core/                         # Shared infrastructure & background engines
│   ├── database/
│   │   ├── cloud/                # Domain contracts + Firestore implementations
│   │   └── local/                # SQLite schema (tables), data services, Riverpod providers
│   ├── SecureStorage/            # Encrypted persistence for local HTTPS identity keys
│   ├── server/                   # Embedded HTTPS server, isolate key generations, QR code & request router
│   ├── storage/media/            # Sandboxed file I/O & visibility-aware in-memory LRU cache
│   └── log/                      # Application-wide logging provider
├── features/                     # Isolated vertical feature slices (data / service / presentation)
│   ├── loginpage/                # Email/password & Google Sign-In
│   ├── waitingToverifyEmailPage/ # Verification gate + rate-limited resend timer
│   ├── UserAdditionalDataRequirementPage/ # A page where the user implement its data 
│   ├── homepage/                 # Semesters overview, settings, linked devices
│   ├── CoursesPage/              # Course management per semester
│   ├── Media/                    # Paginated Images, Videos, Files, All Media & detail viewers
│   ├── DeviceToDeviceMediaSharing/            # Cross-account peer-to-peer sharing (LAN/HTTPS)
│   └── DeviceToDeviceMediaSharingSameAccount/ # Same-account multi-device missing-media sync
├── router/                       # GoRouter setup, redirect gatekeeper & post-login tasks
└── theme/                        # Light/dark palettes & shared typography
```

Each feature strictly separates **Domain Contracts (`*_domain.dart`)**, **Service Logic**, **Data Sources**, and **Presentation (Pages, Widgets, Error Providers)**, allowing backend providers (such as swapping Firestore for a custom REST/SQL backend) to be replaced without modifying UI or business logic.

---

## 2. Core Data Architecture: Local-First & Distributed Sync

### Dual-ID Strategy (`id` vs. `uuid`)
Because multiple devices linked to the same account write to independent local SQLite databases while offline, relying on a local auto-increment counter would cause primary-key collisions upon sync. Every synced table (`Semesters`, `Courses`, `Media`, `Deadlines`) maintains two identifiers:
- **`id` (Local Auto-Increment Integer):** Used exclusively for fast local SQLite lookups, joins, and foreign keys. Never transmitted to Firestore.
- **`uuid` (UUIDv7 String):** Generated client-side using millisecond timestamps in the leading bits plus ~74 bits of randomness (`~1 in 9.4 × 10²¹` collision odds). Used as the Firestore document ID and cross-device identifier.
- **Conflict Resolution:** Concurrent offline edits to the same UUID resolve via a **last-write-wins** strategy based on `updatedAt`.

### Non-Blocking Local-First Writes & Echo-Write Prevention
- **Instant UI Responsiveness:** Mutations (adding or editing semesters, courses, or media) write immediately to SQLite and update Riverpod state without awaiting network resolution. Firestore queues writes locally and reconciles bidirectionally once connectivity returns.
- **Echo-Write Guards:** When the app starts listening to Firestore for semesters and courses, Firestore immediately sends back every item that already exists—and also sends back changes you just saved from your own phone. Before saving anything to SQLite, the app checks if that `uuid` already exists and whether the fields actually changed. This stops the app from creating duplicate items or getting stuck in a loop writing the same data over and over.

---

## 3. Cloud Cost Optimization & Media Sync Model

### Cursor-Based Sync (Zero Snapshot Listeners for Media)
Unlike semesters or courses, a student can accumulate thousands of media items. Attaching a `.snapshots()` listener to the media collection would read every document on startup, inflating Firestore read billing and client CPU load. Instead, media synchronization uses two targeted pull strategies:
1. **`fetchAllMedia`:** Runs once on a brand-new device with no local media history.
2. **`syncMedia`:** Runs on app startup and queries only documents where `updatedAt > lastTimeUpdatedDataFromTheCloud`. Using `updatedAt` rather than `createdAt` ensures both new uploads and metadata edits (renames, descriptions, favorites) are captured in a single delta query.

### Zero Cloud Blob Storage Costs & Anti-Data-Loss Soft Deletion
- **Metadata-Only Cloud Sync:** Only lightweight metadata is stored in Firestore. Heavy binary files (images, videos, documents) remain in sandboxed device storage and transfer directly between devices over local Wi-Fi via the embedded Device-to-Device (D2D) HTTPS server.
- **Device-Scoped Soft Delete:** Because media bytes are not stored in the cloud, deleting a media item—or deleting a parent semester or course—removes metadata locally without wiping binary files from other linked devices. Orphaned media remains accessible and recoverable from the **All Media** view.
- **`mediaExistLocally` Flag:** A local-only boolean tracks whether binary bytes exist on the current device (`true` when created locally; `false` when metadata arrives from Firestore). This avoids expensive filesystem scans and prevents aborted or half-written downloads from being served to peers.

---

## 4. Performance & Memory Engineering

- **Visibility-Aware LRU Media Cache (`cache_provider.dart`):**
  - Grid tiles register images and video thumbnails on mount (`markVisible`) and mark them non-visible on `dispose` rather than evicting immediately.
  - When the cache reaches its hard capacity limit, it evicts the **oldest non-visible entry** while keeping currently visible tiles pinned in memory.
- **Isolate-Offloaded Cryptographic Key Generation:**
  - Local HTTPS server identity keys are generated inside a background Dart `Isolate` (`identity_generation_service.dart`) to prevent UI frame drops when initiating a peer transfer session.
- **Batch State Rebuilds & Pagination Hole-Filling:**
  - **Fast Bulk Syncs Without Freezing the UI:** When the app downloads a large batch of media from Firestore (for example, 200 items at once), it saves all of them into SQLite first and refreshes the screen just once at the end. Updating the Riverpod list one item at a time inside a loop would force Flutter to rebuild the UI 200 times and slow down the phone.
  - Deleting an item from a paginated grid immediately loads one replacement row of the same media type so scroll-threshold triggers never stall.
- **Epoch-Keyed `ProviderScope` Session Reset (`main.dart`):**
  - Wrapping `ProviderScope` in a `ValueKey(_epoch)` inside the root `Application` widget enables a single-call reset on logout. Incrementing `_epoch` disposes the entire `ProviderContainer` (cancelling all active streams and clearing cached user data) while rebuilding providers lazily on-demand—eliminating manual provider invalidation lists as new features are added.

---

## 5. Security, Routing & Multi-Device Identity

- **Embedded HTTPS Server & Human-in-the-Loop D2D Security:**
  - Peer-to-peer transfers spin up a local HTTPS server using locally persisted identity keys and a single-use session token encoded in a QR payload.
  - **Handling One Peer Request Safely at a Time (`RequestRouterService`):** The local server only processes one incoming request at a time—if it is already busy with another transfer, it rejects new requests. Before passing a request to the file-transfer code, it checks three things in order: (1) the sender was approved by the user, (2) the one-time token from the QR code is valid, and (3) the URL path and HTTP method are valid.
  - Upon receiving the first request after a QR scan, the host device immediately presents a live status sheet allowing the user to abort mid-stream (halting byte streaming inside `media_management.dart`) if the scan was unauthorized.
- **Verified-Only Cloud Provisioning & Race-Free Device Tracking:**
  - Profile data entered during registration is held locally until email verification completes, preventing unverified accounts from writing to Firestore.
  - On verified login, device registration (platform device ID + manufacturer/model + FCM token) is awaited in both Firestore and SQLite *before* attaching the FCM token refresh listener, eliminating race conditions on token updates.

---

## 6. Trade-offs & Known Limitations

- **Media Files Require Both Devices to Be Physically Nearby:** Because raw images, videos, and files are stored only on the user's devices and never uploaded to the cloud, Firestore only syncs the metadata (titles, dates, course links). If a user links two devices (such as a phone and a laptop), opens their laptop away from home, and left their phone behind, they can see the names of the media files added on their phone, **but cannot view or download the actual files** until both devices are together on the same local network to run a Device-to-Device (D2D) transfer.

- **Soft Delete Requires Repeating Deletions on Every Device:** Deleting a media item only deletes it from the current device (and removes its metadata from Firestore) so other linked devices do not accidentally lose their local copies. If a user accidentally uploads the wrong file to a course, deleting it on Phone A does **not** remove it from Phone B—they must manually delete it on every other linked device (there is no cross-device "hard delete" yet).

- **Deleting a Course or Semester Leaves "Orphaned" Media Behind:** Deleting a semester or course removes its nested courses, **but intentionally does not delete its media**. Those media files remain on the user's storage as orphaned items until the user either deletes them before deleting the course, or visits the **All Media** page afterward to clean them up manually.

- **Offline "Ghost Semester" Race Condition:** Because semesters and courses are stored in flat collections and synced offline, deleting a semester on Device A while Device B is offline (or currently viewing that semester) allows Device B to temporarily create a new course attached to a "ghost" semester that no longer exists.

- **External File Deletion Desyncs `mediaExistLocally`:** The app relies on a fast SQLite boolean flag (`mediaExistLocally`) instead of scanning the filesystem every time to check if a file exists. If a user opens their device's file manager and deletes files directly from the app's storage folders outside the app, the database still marks those files as `mediaExistLocally = true`, preventing the app from re-fetching them via the D2D missing-media transfer.

- **Repetitive Non-Connection Errors Slow Down Batch D2D Transfers:** During same-account D2D sync, single-file errors (such as a missing file on the sender) are skipped so one bad file does not cancel the entire batch, while connection drops abort immediately. If a user requests hundreds of files and a non-connection error happens repeatedly on every file, they must wait for the loop to fail through the queue rather than aborting on the first repeated error.

- **Platform Support:** Because the app is distributed openly on GitHub with direct APK/installer downloads rather than through Apple's closed App Store ecosystem, iOS is not supported; Windows is a planned platform.