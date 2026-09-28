// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceToken {
  final String userUid;
  final String uniqueDeviceAccountId;
  final String notificationToken;
  final String deviceName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DeviceToken({
    required this.userUid,
    required this.uniqueDeviceAccountId,
    required this.notificationToken,
    required this.deviceName,
    this.createdAt,
    this.updatedAt,
  });

  DeviceToken copyWith({
    String? userUid,
    String? uniqueDeviceAccountId,
    String? notificationToken,
    String? deviceName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DeviceToken(
      userUid: userUid ?? this.userUid,
      uniqueDeviceAccountId: uniqueDeviceAccountId ?? this.uniqueDeviceAccountId,
      notificationToken: notificationToken ?? this.notificationToken,
      deviceName: deviceName ?? this.deviceName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_uid': userUid,
      'unique_device_account_id': uniqueDeviceAccountId,
      'notification_token': notificationToken,
      'device_name': deviceName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory DeviceToken.fromJson(Map<String, dynamic> json) {
    return DeviceToken(
      userUid: json['user_uid'] as String,
      uniqueDeviceAccountId: json['unique_device_account_id'] as String,
      notificationToken: json['notification_token'] as String,
      deviceName: json['device_name'] as String,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at'] as String) : null,
    );
  }

  
  Map<String, dynamic> toFirestore() {
  return {
    'user_uid': userUid,
    'notification_token': notificationToken,
    'device_name': deviceName,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

  factory DeviceToken.fromFirestore(
  Map<String, dynamic> data, {
  required String uniqueDeviceAccountId,
}) {
  return DeviceToken(
    userUid: data['user_uid'] as String,
    uniqueDeviceAccountId: uniqueDeviceAccountId,
    notificationToken: data['notification_token'] as String,
    deviceName: data['device_name'] as String,
    createdAt: data['created_at'] != null ? (data['created_at'] as Timestamp).toDate() : null,
    updatedAt: data['updated_at'] != null ? (data['updated_at'] as Timestamp).toDate() : null,
  );
}

  @override
  String toString() {
    return 'DeviceToken(userUid: $userUid, uniqueDeviceAccountId: $uniqueDeviceAccountId, '
        'notificationToken: $notificationToken, deviceName: $deviceName, '
        'createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}