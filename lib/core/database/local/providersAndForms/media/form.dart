import 'package:cloud_firestore/cloud_firestore.dart';

class MediaForm {
  final int? id; //auto generated in the db
  final String? uuid; //auto generated inside the sql db
  final String userUid;
  final String courseUuid;
  final String filename;
  final String? fileDescription; //optional
  final String filepath; //note that the path is logical, not a real device path
  final String filetype;
  final int filesizeByte;
  final bool isFavorite;
  final DateTime? createdAt; //auto generated in the db
  final DateTime? updatedAt; //auto generated in the db

  const MediaForm({
    this.id,
    this.uuid,
    required this.userUid,
    required this.courseUuid,
    required this.filename,
    this.fileDescription,
    required this.filepath,
    required this.filetype,
    required this.filesizeByte,
    required this.isFavorite,
    this.createdAt,
    this.updatedAt,
  });

  ///NOTE: this function is used to compare media,
  ///used to prevent echo writes while listening to the cloud inside media_provider,
  ///u can use it anywhere else if u may need comparing two media items
  bool hasSameContentAs(MediaForm other) {
    return uuid == other.uuid &&
        userUid == other.userUid &&
        courseUuid == other.courseUuid &&
        filename == other.filename &&
        fileDescription == other.fileDescription &&
        filepath == other.filepath &&
        filetype == other.filetype &&
        filesizeByte == other.filesizeByte &&
        isFavorite == other.isFavorite;
  }

  MediaForm copyWith({
    int? id,
    String? uuid,
    String? userUid,
    String? courseUuid,
    String? filename,
    String? fileDescription,
    String? filepath,
    String? filetype,
    int? filesizeByte,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MediaForm(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userUid: userUid ?? this.userUid,
      courseUuid: courseUuid ?? this.courseUuid,
      filename: filename ?? this.filename,
      fileDescription: fileDescription ?? this.fileDescription,
      filepath: filepath ?? this.filepath,
      filetype: filetype ?? this.filetype,
      filesizeByte: filesizeByte ?? this.filesizeByte,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      // we don't pass "id" here, id is only for local queries so queries go faster
      // also we don't pass "uuid" here, uuid is the document id
      'user_uid': userUid,
      'course_uuid': courseUuid,
      'filename': filename,
      'file_description': fileDescription,
      'filepath': filepath,
      'filetype': filetype,
      'filesize_byte': filesizeByte,
      'is_favorite': isFavorite,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory MediaForm.fromFirestore(Map<String, dynamic> data, String uuid) {
    return MediaForm(
      // id is not stored in Firestore, it's local-only, so it stays null here
      uuid: uuid,
      userUid: data['user_uid'] as String,
      courseUuid: data['course_uuid'] as String,
      filename: data['filename'] as String,
      fileDescription: data['file_description'] as String,
      filepath: data['filepath'] as String,
      filetype: data['filetype'] as String,
      filesizeByte: data['filesize_byte'] as int,
      isFavorite: data['is_favorite'] as bool,
      createdAt: (data['created_at'] as Timestamp?)?.toDate(),
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'user_uid': userUid,
      'course_uuid': courseUuid,
      'filename': filename,
      'file_description': fileDescription,
      'filepath': filepath,
      'filetype': filetype,
      'filesize_byte': filesizeByte,
      'is_favorite': isFavorite,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory MediaForm.fromJson(Map<String, dynamic> json) {
    return MediaForm(
      uuid: json['uuid'] as String?,
      userUid: json['user_uid'] as String,
      courseUuid: json['course_uuid'] as String,
      filename: json['filename'] as String,
      fileDescription: json['file_description'] as String,
      filepath: json['filepath'] as String,
      filetype: json['filetype'] as String,
      filesizeByte: json['filesize_byte'] as int,
      isFavorite: json['is_favorite'] as bool,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
    );
  }
}