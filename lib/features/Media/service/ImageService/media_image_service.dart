import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/media/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/service/ImageService/media_image_service_domain.dart';

class MediaImageService extends Notifier<void> implements MediaImageServiceDomain {
  @override
  Future<Uint8List?> addMedia(MediaForm data) {
    // TODO: implement addMedia
    throw UnimplementedError();
  }

  @override
  void build() {
    // TODO: implement build
  }

  @override
  Future<void> deleteMedia(int id) {
    // TODO: implement deleteMedia
    throw UnimplementedError();
  }

  @override
  Future<void> markInvisibleImage(int id) {
    // TODO: implement markInvisibleImage
    throw UnimplementedError();
  }

  @override
  Future<Uint8List?> returnMediaImage(int id) {
    // TODO: implement returnMediaImage
    throw UnimplementedError();
  }

  @override
  Future<void> updateMedia(MediaForm data) {
    // TODO: implement updateMedia
    throw UnimplementedError();
  }


}