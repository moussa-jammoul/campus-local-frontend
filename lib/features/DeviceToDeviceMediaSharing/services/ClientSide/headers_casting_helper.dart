import 'package:dio/dio.dart';

class MediaHeaderData {
  final String fileType;
  final String fileName;
  final String fileDescription;
  final int fileSizeByte;

  const MediaHeaderData({
    required this.fileType,
    required this.fileName,
    required this.fileDescription,
    required this.fileSizeByte,
  });

  
  static MediaHeaderData? fromHeaders(Headers headers) {
    final type = headers.value('media-extension');
    final name = headers.value('media-name');
    final size = int.tryParse(headers.value('media-size') ?? '');

    if (type == null || name == null || size == null) return null;

    return MediaHeaderData(
      fileType: _decode(type),
      fileName: _decode(name),
      fileDescription: _decode(headers.value('media-description') ?? 'A Media'),
      fileSizeByte: size,
    );
  }

  static String _decode(String value) {
    try {
      return Uri.decodeComponent(value);
    } catch (_) {
      return value; 
    }
  }
}