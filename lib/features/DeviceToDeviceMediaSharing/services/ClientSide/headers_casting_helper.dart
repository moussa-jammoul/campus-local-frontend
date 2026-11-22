import 'package:dio/dio.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
class MediaHeaderData {
  final String fileType;
  final String fileName;
  final String fileDescription;
  

  const MediaHeaderData({
    required this.fileType,
    required this.fileName,
    required this.fileDescription,
    
  });

  
  static MediaHeaderData? fromHeaders(Headers headers) {
    final type = headers.value('media-extension');
    final name = headers.value('media-name');
    

    if (type == null || name == null) return null;

    return MediaHeaderData(
      fileType: _decode(type),
      fileName: _decode(name),
      fileDescription: _decode(headers.value('media-description') ?? 'A Media'),
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