import 'dart:typed_data';

//int is the id of the media (not the uuid), for fast look-up
typedef MediaImageCache = Map<int,Uint8List>;

//string is the video uuid , we used this uuid to be the same name for thumbnails
typedef MediaVideoThumbnailCache = Map<String,Uint8List>; 