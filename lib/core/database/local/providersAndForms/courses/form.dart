import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final int? id; // auto generated inside the sql db
  final String? uuid; // auto generated inside the sql db
  final String userUid;
  final String semesterUuid;
  final String courseName;
  final String description;
  final String professorName;
  final DateTime? createdAt; // auto generated in the db
  final DateTime? updatedAt; // auto generated in the db

  const Course({
    this.id,
    this.uuid,
    required this.userUid,
    required this.semesterUuid,
    required this.courseName,
    required this.description,
    required this.professorName,
    this.createdAt,
    this.updatedAt,
  });

  ///NOTE: this function is used to compare courses,
  ///used to prevent echo writes while listening to the cloud inside course_provider,
  ///u can use it anywhere else if u may need comparing two courses
  bool hasSameContentAs(Course other) {
    return uuid == other.uuid &&
        userUid == other.userUid &&
        semesterUuid == other.semesterUuid &&
        courseName == other.courseName &&
        description == other.description &&
        professorName == other.professorName;
  }

  Course copyWith({
    int? id,
    String? uuid,
    String? userUid,
    String? semesterUuid,
    String? courseName,
    String? description,
    String? professorName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Course(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userUid: userUid ?? this.userUid,
      semesterUuid: semesterUuid ?? this.semesterUuid,
      courseName: courseName ?? this.courseName,
      description: description ?? this.description,
      professorName: professorName ?? this.professorName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      // we don't pass "id" here, id is only for local queries so queries go faster
      // also we don't pass "uuid" here, uuid is the document id
      'user_uid': userUid,
      'semester_uuid': semesterUuid,
      'course_name': courseName,
      'description': description,
      'professor_name': professorName,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory Course.fromFirestore(Map<String, dynamic> data, String uuid) {
    return Course(
      // id is not stored in Firestore, it's local-only, so it stays null here
      uuid: uuid,
      userUid: data['user_uid'] as String,
      semesterUuid: data['semester_uuid'] as String,
      courseName: data['course_name'] as String,
      description: data['description'] as String,
      professorName: data['professor_name'] as String,
      createdAt: (data['created_at'] as Timestamp?)?.toDate(),
      updatedAt: (data['updated_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'user_uid': userUid,
      'semester_uuid': semesterUuid,
      'course_name': courseName,
      'description': description,
      'professor_name': professorName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      uuid: json['uuid'] as String?,
      userUid: json['user_uid'] as String,
      semesterUuid: json['semester_uuid'] as String,
      courseName: json['course_name'] as String,
      description: json['description'] as String,
      professorName: json['professor_name'] as String,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
    );
  }
}