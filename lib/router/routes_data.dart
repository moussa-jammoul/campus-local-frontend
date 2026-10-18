//this file and those clases used to pass multiple objects / data between routes for a cleaner / readable code

import 'package:flutter/foundation.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';

class ImageRouteData {
  final Uint8List? bytes;
  final MediaForm imageDetail;
  const ImageRouteData({
    required this.bytes,
    required this.imageDetail
  });
}

class VideoRouteData {
  final String? explicitPath;
  final MediaForm videoDetails;
  const VideoRouteData({
    required this.explicitPath,
    required this.videoDetails
  });

}