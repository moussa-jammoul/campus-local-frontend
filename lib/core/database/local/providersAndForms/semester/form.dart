import 'package:cloud_firestore/cloud_firestore.dart';

class Semester {
  final int? id; //auto generated inside the sql db
  final String? uuid; //auto generated inside the sql db
  final String userUid;
  final String semesterName;
  final String description;
  final bool finishedOrYet;
  final DateTime? createdAt;//auto generated in the db
  final DateTime? updatedAt;//auto generated in the db

  const Semester({
    this.id,
    this.uuid,
    required this.userUid,
    required this.semesterName,
    required this.description,
    required this.finishedOrYet,
    this.createdAt,
    this.updatedAt,
  });

  ///NOTE: this function is used to compare semester , 
  ///i created it so it is used to prevent echo writes for updating the semester while listening to the cloud
  ///inside the semester_provider  , u can use it anywhere else if u may need comparing two semesters
  bool hasSameContentAs(Semester other) {
    return uuid == other.uuid &&
        userUid == other.userUid &&
        semesterName == other.semesterName &&
        description == other.description &&
        finishedOrYet == other.finishedOrYet;
  }


  Semester copyWith({
  int? id,
  String? uuid,
  String? userUid,
  String? semesterName,
  String? description,
  bool? finishedOrYet,
  DateTime? createdAt,
  DateTime? updatedAt,
  }) {
  return Semester(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    userUid: userUid ?? this.userUid,
    semesterName: semesterName ?? this.semesterName,
    description: description ?? this.description,
    finishedOrYet: finishedOrYet ?? this.finishedOrYet,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? DateTime.now(),
  );
  }
  
  Map<String, dynamic> toFirestore() {
  return {
    // we don't pass "id" here, id is only for local queries so queries go faster
    //also we don't pass here uuid ,  because uuid is the document id
    'user_uid': userUid,
    'semester_name': semesterName,
    'description': description,
    'finished_or_yet': finishedOrYet,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

factory Semester.fromFirestore(Map<String, dynamic> data , String uuid) {
  return Semester(
    // id is not stored in Firestore, it's local-only, so it stays null here
    uuid: uuid,
    userUid: data['user_uid'] as String,
    semesterName: data['semester_name'] as String,
    description: data['description'] as String,
    finishedOrYet: data['finished_or_yet'] as bool,
    createdAt: (data['created_at'] as Timestamp?)?.toDate(),
    updatedAt: (data['updated_at'] as Timestamp?)?.toDate(),
  );
}


Map<String, dynamic> toJson() {
  return {
    'uuid': uuid,
    'user_uid': userUid,
    'semester_name': semesterName,
    'description': description,
    'finished_or_yet': finishedOrYet,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

factory Semester.fromJson(Map<String, dynamic> json) {
  return Semester(
    uuid: json['uuid'] as String?,
    userUid: json['user_uid'] as String,
    semesterName: json['semester_name'] as String,
    description: json['description'] as String,
    finishedOrYet: json['finished_or_yet'] as bool,
    createdAt: json['created_at'] != null
        ? DateTime.parse(json['created_at'] as String)
        : null,
    updatedAt: json['updated_at'] != null
        ? DateTime.parse(json['updated_at'] as String)
        : null,
  );
}






}