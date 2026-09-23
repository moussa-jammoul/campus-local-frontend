import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String fullname;
  final String email;
  final String major;
  final String role;
  final String dateOfBirth;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserData({
    required this.fullname,
    required this.email,
    required this.major,
    required this.role,
    required this.dateOfBirth,
    required this.createdAt,
    required this.updatedAt,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'email': email,
      'major': major,
      'role': role,
      'date_of_birth': dateOfBirth,
      'created_at': Timestamp.fromDate(createdAt.toUtc()),
      'updated_at': Timestamp.fromDate(updatedAt.toUtc()),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {

    return UserData(
      fullname: map['fullname'] as String,
      email: map['email'] as String,
      major: map['major'] as String,
      role: map['role'] as String,
     
      dateOfBirth: map['date_of_birth'] as String,
      createdAt: (map['created_at'] as Timestamp).toDate(),
      updatedAt: (map['updated_at'] as Timestamp).toDate(),
    );
  }

  UserData copyWith({
    String? fullname,
    String? email,
    String? major,
    String? role,
    String? dateOfBirth,
    DateTime? updatedAt,
  }) {
    return UserData(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      major: major ?? this.major,
      role: role ?? this.role,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now().toUtc(),
    );
  }
}