

import 'package:cloud_firestore/cloud_firestore.dart';

class UserAdditionalData {
  final String email;
  final String uid; // only used for local read and splitting between accounts in the same device
  final String fullname;
  final String dateOfBirth;
  final String role;
  final String major;
  final DateTime? createdAt;
  final DateTime? updatedAt;


  const UserAdditionalData({
    required this.uid,
    required this.email,
    required this.fullname,
    required this.dateOfBirth,
    required this.role,
    required this.major,
    this.createdAt,
    this.updatedAt,
  });

  UserAdditionalData copyWith({
    String? uid,
    String? email,
    String? fullname,
    String? dateOfBirth,
    String? role,
    String? major,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserAdditionalData(
      uid : uid ?? this.uid,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      role: role ?? this.role,
      major: major ?? this.major,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
  

  // those two are used especially for firestore  , for a custom backend , use the from json and to json
  Map<String, dynamic> toFirestore() {
  return {
    //we don't need here uid 
    'email': email,
    'fullname': fullname,
    'date_of_birth': dateOfBirth,
    'role': role,
    'major': major,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
  }

  factory UserAdditionalData.fromFirestore(Map<String, dynamic> data , String uid) {
    return UserAdditionalData(
      uid: uid,//firestore snapshot does not have uid , so we rely to pass it as a parameter instead
      email: data['email'] as String,
      fullname: data['fullname'] as String,
      dateOfBirth: data['date_of_birth'] as String,
      role: data['role'] as String,
      major: data['major'] as String,
      createdAt: (data['created_at'] as Timestamp).toDate(),
      updatedAt: (data['updated_at'] as Timestamp).toDate(),
    );
  }
  //not used for firestore , because firestore handle date time natively
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullname': fullname,
      'date_of_birth': dateOfBirth,
      'role': role,
      'major': major,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory UserAdditionalData.fromJson(Map<String, dynamic> json) {
    return UserAdditionalData(
      uid: json['uid'] as String,
      email: json['email'] as String,
      fullname: json['fullname'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      role: json['role'] as String,
      major: json['major'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

}