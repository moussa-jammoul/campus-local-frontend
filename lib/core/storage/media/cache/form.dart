import 'dart:typed_data';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.

//int is the id of the media (not the uuid), for fast look-up
typedef MediaImageCache = Map<int,Uint8List>;

//string is the video uuid , we used this uuid to be the same name for thumbnails
typedef MediaVideoThumbnailCache = Map<String,Uint8List>; 