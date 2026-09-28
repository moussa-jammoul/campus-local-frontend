// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_db.dart';

// ignore_for_file: type=lint
class $AdditionalUserDataDBTable extends AdditionalUserDataDB
    with TableInfo<$AdditionalUserDataDBTable, AdditionalUserDataDBData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdditionalUserDataDBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullnameMeta = const VerificationMeta(
    'fullname',
  );
  @override
  late final GeneratedColumn<String> fullname = GeneratedColumn<String>(
    'fullname',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<String> dateOfBirth = GeneratedColumn<String>(
    'date_of_birth',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _majorMeta = const VerificationMeta('major');
  @override
  late final GeneratedColumn<String> major = GeneratedColumn<String>(
    'major',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    uid,
    email,
    fullname,
    dateOfBirth,
    role,
    major,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'additional_user_data_d_b';
  @override
  VerificationContext validateIntegrity(
    Insertable<AdditionalUserDataDBData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('fullname')) {
      context.handle(
        _fullnameMeta,
        fullname.isAcceptableOrUnknown(data['fullname']!, _fullnameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullnameMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('major')) {
      context.handle(
        _majorMeta,
        major.isAcceptableOrUnknown(data['major']!, _majorMeta),
      );
    } else if (isInserting) {
      context.missing(_majorMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  AdditionalUserDataDBData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdditionalUserDataDBData(
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      fullname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fullname'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_of_birth'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      major: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}major'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AdditionalUserDataDBTable createAlias(String alias) {
    return $AdditionalUserDataDBTable(attachedDatabase, alias);
  }
}

class AdditionalUserDataDBData extends DataClass
    implements Insertable<AdditionalUserDataDBData> {
  final String uid;
  final String email;
  final String fullname;
  final String dateOfBirth;
  final String role;
  final String major;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AdditionalUserDataDBData({
    required this.uid,
    required this.email,
    required this.fullname,
    required this.dateOfBirth,
    required this.role,
    required this.major,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['email'] = Variable<String>(email);
    map['fullname'] = Variable<String>(fullname);
    map['date_of_birth'] = Variable<String>(dateOfBirth);
    map['role'] = Variable<String>(role);
    map['major'] = Variable<String>(major);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AdditionalUserDataDBCompanion toCompanion(bool nullToAbsent) {
    return AdditionalUserDataDBCompanion(
      uid: Value(uid),
      email: Value(email),
      fullname: Value(fullname),
      dateOfBirth: Value(dateOfBirth),
      role: Value(role),
      major: Value(major),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AdditionalUserDataDBData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdditionalUserDataDBData(
      uid: serializer.fromJson<String>(json['uid']),
      email: serializer.fromJson<String>(json['email']),
      fullname: serializer.fromJson<String>(json['fullname']),
      dateOfBirth: serializer.fromJson<String>(json['dateOfBirth']),
      role: serializer.fromJson<String>(json['role']),
      major: serializer.fromJson<String>(json['major']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'email': serializer.toJson<String>(email),
      'fullname': serializer.toJson<String>(fullname),
      'dateOfBirth': serializer.toJson<String>(dateOfBirth),
      'role': serializer.toJson<String>(role),
      'major': serializer.toJson<String>(major),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AdditionalUserDataDBData copyWith({
    String? uid,
    String? email,
    String? fullname,
    String? dateOfBirth,
    String? role,
    String? major,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AdditionalUserDataDBData(
    uid: uid ?? this.uid,
    email: email ?? this.email,
    fullname: fullname ?? this.fullname,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    role: role ?? this.role,
    major: major ?? this.major,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AdditionalUserDataDBData copyWithCompanion(
    AdditionalUserDataDBCompanion data,
  ) {
    return AdditionalUserDataDBData(
      uid: data.uid.present ? data.uid.value : this.uid,
      email: data.email.present ? data.email.value : this.email,
      fullname: data.fullname.present ? data.fullname.value : this.fullname,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      role: data.role.present ? data.role.value : this.role,
      major: data.major.present ? data.major.value : this.major,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdditionalUserDataDBData(')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('fullname: $fullname, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('role: $role, ')
          ..write('major: $major, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uid,
    email,
    fullname,
    dateOfBirth,
    role,
    major,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdditionalUserDataDBData &&
          other.uid == this.uid &&
          other.email == this.email &&
          other.fullname == this.fullname &&
          other.dateOfBirth == this.dateOfBirth &&
          other.role == this.role &&
          other.major == this.major &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AdditionalUserDataDBCompanion
    extends UpdateCompanion<AdditionalUserDataDBData> {
  final Value<String> uid;
  final Value<String> email;
  final Value<String> fullname;
  final Value<String> dateOfBirth;
  final Value<String> role;
  final Value<String> major;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AdditionalUserDataDBCompanion({
    this.uid = const Value.absent(),
    this.email = const Value.absent(),
    this.fullname = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.role = const Value.absent(),
    this.major = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AdditionalUserDataDBCompanion.insert({
    required String uid,
    required String email,
    required String fullname,
    required String dateOfBirth,
    required String role,
    required String major,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uid = Value(uid),
       email = Value(email),
       fullname = Value(fullname),
       dateOfBirth = Value(dateOfBirth),
       role = Value(role),
       major = Value(major);
  static Insertable<AdditionalUserDataDBData> custom({
    Expression<String>? uid,
    Expression<String>? email,
    Expression<String>? fullname,
    Expression<String>? dateOfBirth,
    Expression<String>? role,
    Expression<String>? major,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (email != null) 'email': email,
      if (fullname != null) 'fullname': fullname,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (role != null) 'role': role,
      if (major != null) 'major': major,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AdditionalUserDataDBCompanion copyWith({
    Value<String>? uid,
    Value<String>? email,
    Value<String>? fullname,
    Value<String>? dateOfBirth,
    Value<String>? role,
    Value<String>? major,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AdditionalUserDataDBCompanion(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      role: role ?? this.role,
      major: major ?? this.major,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (fullname.present) {
      map['fullname'] = Variable<String>(fullname.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<String>(dateOfBirth.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (major.present) {
      map['major'] = Variable<String>(major.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdditionalUserDataDBCompanion(')
          ..write('uid: $uid, ')
          ..write('email: $email, ')
          ..write('fullname: $fullname, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('role: $role, ')
          ..write('major: $major, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeviceTokenDBTable extends DeviceTokenDB
    with TableInfo<$DeviceTokenDBTable, DeviceTokenDBData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceTokenDBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userUidMeta = const VerificationMeta(
    'userUid',
  );
  @override
  late final GeneratedColumn<String> userUid = GeneratedColumn<String>(
    'user_uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notifictionTokenMeta = const VerificationMeta(
    'notifictionToken',
  );
  @override
  late final GeneratedColumn<String> notifictionToken = GeneratedColumn<String>(
    'notifiction_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceAccountUniqueKeyMeta =
      const VerificationMeta('deviceAccountUniqueKey');
  @override
  late final GeneratedColumn<String> deviceAccountUniqueKey =
      GeneratedColumn<String>(
        'device_account_unique_key',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _deviceNameMeta = const VerificationMeta(
    'deviceName',
  );
  @override
  late final GeneratedColumn<String> deviceName = GeneratedColumn<String>(
    'device_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    userUid,
    notifictionToken,
    deviceAccountUniqueKey,
    deviceName,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_token_d_b';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceTokenDBData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_uid')) {
      context.handle(
        _userUidMeta,
        userUid.isAcceptableOrUnknown(data['user_uid']!, _userUidMeta),
      );
    } else if (isInserting) {
      context.missing(_userUidMeta);
    }
    if (data.containsKey('notifiction_token')) {
      context.handle(
        _notifictionTokenMeta,
        notifictionToken.isAcceptableOrUnknown(
          data['notifiction_token']!,
          _notifictionTokenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notifictionTokenMeta);
    }
    if (data.containsKey('device_account_unique_key')) {
      context.handle(
        _deviceAccountUniqueKeyMeta,
        deviceAccountUniqueKey.isAcceptableOrUnknown(
          data['device_account_unique_key']!,
          _deviceAccountUniqueKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceAccountUniqueKeyMeta);
    }
    if (data.containsKey('device_name')) {
      context.handle(
        _deviceNameMeta,
        deviceName.isAcceptableOrUnknown(data['device_name']!, _deviceNameMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deviceAccountUniqueKey};
  @override
  DeviceTokenDBData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceTokenDBData(
      userUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_uid'],
      )!,
      notifictionToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notifiction_token'],
      )!,
      deviceAccountUniqueKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_account_unique_key'],
      )!,
      deviceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DeviceTokenDBTable createAlias(String alias) {
    return $DeviceTokenDBTable(attachedDatabase, alias);
  }
}

class DeviceTokenDBData extends DataClass
    implements Insertable<DeviceTokenDBData> {
  final String userUid;
  final String notifictionToken;
  final String deviceAccountUniqueKey;
  final String deviceName;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DeviceTokenDBData({
    required this.userUid,
    required this.notifictionToken,
    required this.deviceAccountUniqueKey,
    required this.deviceName,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_uid'] = Variable<String>(userUid);
    map['notifiction_token'] = Variable<String>(notifictionToken);
    map['device_account_unique_key'] = Variable<String>(deviceAccountUniqueKey);
    map['device_name'] = Variable<String>(deviceName);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DeviceTokenDBCompanion toCompanion(bool nullToAbsent) {
    return DeviceTokenDBCompanion(
      userUid: Value(userUid),
      notifictionToken: Value(notifictionToken),
      deviceAccountUniqueKey: Value(deviceAccountUniqueKey),
      deviceName: Value(deviceName),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DeviceTokenDBData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceTokenDBData(
      userUid: serializer.fromJson<String>(json['userUid']),
      notifictionToken: serializer.fromJson<String>(json['notifictionToken']),
      deviceAccountUniqueKey: serializer.fromJson<String>(
        json['deviceAccountUniqueKey'],
      ),
      deviceName: serializer.fromJson<String>(json['deviceName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userUid': serializer.toJson<String>(userUid),
      'notifictionToken': serializer.toJson<String>(notifictionToken),
      'deviceAccountUniqueKey': serializer.toJson<String>(
        deviceAccountUniqueKey,
      ),
      'deviceName': serializer.toJson<String>(deviceName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DeviceTokenDBData copyWith({
    String? userUid,
    String? notifictionToken,
    String? deviceAccountUniqueKey,
    String? deviceName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DeviceTokenDBData(
    userUid: userUid ?? this.userUid,
    notifictionToken: notifictionToken ?? this.notifictionToken,
    deviceAccountUniqueKey:
        deviceAccountUniqueKey ?? this.deviceAccountUniqueKey,
    deviceName: deviceName ?? this.deviceName,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DeviceTokenDBData copyWithCompanion(DeviceTokenDBCompanion data) {
    return DeviceTokenDBData(
      userUid: data.userUid.present ? data.userUid.value : this.userUid,
      notifictionToken: data.notifictionToken.present
          ? data.notifictionToken.value
          : this.notifictionToken,
      deviceAccountUniqueKey: data.deviceAccountUniqueKey.present
          ? data.deviceAccountUniqueKey.value
          : this.deviceAccountUniqueKey,
      deviceName: data.deviceName.present
          ? data.deviceName.value
          : this.deviceName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceTokenDBData(')
          ..write('userUid: $userUid, ')
          ..write('notifictionToken: $notifictionToken, ')
          ..write('deviceAccountUniqueKey: $deviceAccountUniqueKey, ')
          ..write('deviceName: $deviceName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userUid,
    notifictionToken,
    deviceAccountUniqueKey,
    deviceName,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceTokenDBData &&
          other.userUid == this.userUid &&
          other.notifictionToken == this.notifictionToken &&
          other.deviceAccountUniqueKey == this.deviceAccountUniqueKey &&
          other.deviceName == this.deviceName &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DeviceTokenDBCompanion extends UpdateCompanion<DeviceTokenDBData> {
  final Value<String> userUid;
  final Value<String> notifictionToken;
  final Value<String> deviceAccountUniqueKey;
  final Value<String> deviceName;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DeviceTokenDBCompanion({
    this.userUid = const Value.absent(),
    this.notifictionToken = const Value.absent(),
    this.deviceAccountUniqueKey = const Value.absent(),
    this.deviceName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceTokenDBCompanion.insert({
    required String userUid,
    required String notifictionToken,
    required String deviceAccountUniqueKey,
    required String deviceName,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userUid = Value(userUid),
       notifictionToken = Value(notifictionToken),
       deviceAccountUniqueKey = Value(deviceAccountUniqueKey),
       deviceName = Value(deviceName);
  static Insertable<DeviceTokenDBData> custom({
    Expression<String>? userUid,
    Expression<String>? notifictionToken,
    Expression<String>? deviceAccountUniqueKey,
    Expression<String>? deviceName,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userUid != null) 'user_uid': userUid,
      if (notifictionToken != null) 'notifiction_token': notifictionToken,
      if (deviceAccountUniqueKey != null)
        'device_account_unique_key': deviceAccountUniqueKey,
      if (deviceName != null) 'device_name': deviceName,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceTokenDBCompanion copyWith({
    Value<String>? userUid,
    Value<String>? notifictionToken,
    Value<String>? deviceAccountUniqueKey,
    Value<String>? deviceName,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DeviceTokenDBCompanion(
      userUid: userUid ?? this.userUid,
      notifictionToken: notifictionToken ?? this.notifictionToken,
      deviceAccountUniqueKey:
          deviceAccountUniqueKey ?? this.deviceAccountUniqueKey,
      deviceName: deviceName ?? this.deviceName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userUid.present) {
      map['user_uid'] = Variable<String>(userUid.value);
    }
    if (notifictionToken.present) {
      map['notifiction_token'] = Variable<String>(notifictionToken.value);
    }
    if (deviceAccountUniqueKey.present) {
      map['device_account_unique_key'] = Variable<String>(
        deviceAccountUniqueKey.value,
      );
    }
    if (deviceName.present) {
      map['device_name'] = Variable<String>(deviceName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceTokenDBCompanion(')
          ..write('userUid: $userUid, ')
          ..write('notifictionToken: $notifictionToken, ')
          ..write('deviceAccountUniqueKey: $deviceAccountUniqueKey, ')
          ..write('deviceName: $deviceName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AdditionalUserDataDBTable additionalUserDataDB =
      $AdditionalUserDataDBTable(this);
  late final $DeviceTokenDBTable deviceTokenDB = $DeviceTokenDBTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    additionalUserDataDB,
    deviceTokenDB,
  ];
}

typedef $$AdditionalUserDataDBTableCreateCompanionBuilder =
    AdditionalUserDataDBCompanion Function({
      required String uid,
      required String email,
      required String fullname,
      required String dateOfBirth,
      required String role,
      required String major,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AdditionalUserDataDBTableUpdateCompanionBuilder =
    AdditionalUserDataDBCompanion Function({
      Value<String> uid,
      Value<String> email,
      Value<String> fullname,
      Value<String> dateOfBirth,
      Value<String> role,
      Value<String> major,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AdditionalUserDataDBTableFilterComposer
    extends Composer<_$AppDatabase, $AdditionalUserDataDBTable> {
  $$AdditionalUserDataDBTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullname => $composableBuilder(
    column: $table.fullname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get major => $composableBuilder(
    column: $table.major,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AdditionalUserDataDBTableOrderingComposer
    extends Composer<_$AppDatabase, $AdditionalUserDataDBTable> {
  $$AdditionalUserDataDBTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullname => $composableBuilder(
    column: $table.fullname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get major => $composableBuilder(
    column: $table.major,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AdditionalUserDataDBTableAnnotationComposer
    extends Composer<_$AppDatabase, $AdditionalUserDataDBTable> {
  $$AdditionalUserDataDBTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get fullname =>
      $composableBuilder(column: $table.fullname, builder: (column) => column);

  GeneratedColumn<String> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get major =>
      $composableBuilder(column: $table.major, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AdditionalUserDataDBTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AdditionalUserDataDBTable,
          AdditionalUserDataDBData,
          $$AdditionalUserDataDBTableFilterComposer,
          $$AdditionalUserDataDBTableOrderingComposer,
          $$AdditionalUserDataDBTableAnnotationComposer,
          $$AdditionalUserDataDBTableCreateCompanionBuilder,
          $$AdditionalUserDataDBTableUpdateCompanionBuilder,
          (
            AdditionalUserDataDBData,
            BaseReferences<
              _$AppDatabase,
              $AdditionalUserDataDBTable,
              AdditionalUserDataDBData
            >,
          ),
          AdditionalUserDataDBData,
          PrefetchHooks Function()
        > {
  $$AdditionalUserDataDBTableTableManager(
    _$AppDatabase db,
    $AdditionalUserDataDBTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AdditionalUserDataDBTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AdditionalUserDataDBTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AdditionalUserDataDBTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> uid = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> fullname = const Value.absent(),
                Value<String> dateOfBirth = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> major = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AdditionalUserDataDBCompanion(
                uid: uid,
                email: email,
                fullname: fullname,
                dateOfBirth: dateOfBirth,
                role: role,
                major: major,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uid,
                required String email,
                required String fullname,
                required String dateOfBirth,
                required String role,
                required String major,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AdditionalUserDataDBCompanion.insert(
                uid: uid,
                email: email,
                fullname: fullname,
                dateOfBirth: dateOfBirth,
                role: role,
                major: major,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AdditionalUserDataDBTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AdditionalUserDataDBTable,
      AdditionalUserDataDBData,
      $$AdditionalUserDataDBTableFilterComposer,
      $$AdditionalUserDataDBTableOrderingComposer,
      $$AdditionalUserDataDBTableAnnotationComposer,
      $$AdditionalUserDataDBTableCreateCompanionBuilder,
      $$AdditionalUserDataDBTableUpdateCompanionBuilder,
      (
        AdditionalUserDataDBData,
        BaseReferences<
          _$AppDatabase,
          $AdditionalUserDataDBTable,
          AdditionalUserDataDBData
        >,
      ),
      AdditionalUserDataDBData,
      PrefetchHooks Function()
    >;
typedef $$DeviceTokenDBTableCreateCompanionBuilder =
    DeviceTokenDBCompanion Function({
      required String userUid,
      required String notifictionToken,
      required String deviceAccountUniqueKey,
      required String deviceName,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$DeviceTokenDBTableUpdateCompanionBuilder =
    DeviceTokenDBCompanion Function({
      Value<String> userUid,
      Value<String> notifictionToken,
      Value<String> deviceAccountUniqueKey,
      Value<String> deviceName,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DeviceTokenDBTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceTokenDBTable> {
  $$DeviceTokenDBTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userUid => $composableBuilder(
    column: $table.userUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notifictionToken => $composableBuilder(
    column: $table.notifictionToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceAccountUniqueKey => $composableBuilder(
    column: $table.deviceAccountUniqueKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeviceTokenDBTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceTokenDBTable> {
  $$DeviceTokenDBTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userUid => $composableBuilder(
    column: $table.userUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notifictionToken => $composableBuilder(
    column: $table.notifictionToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceAccountUniqueKey => $composableBuilder(
    column: $table.deviceAccountUniqueKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeviceTokenDBTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceTokenDBTable> {
  $$DeviceTokenDBTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userUid =>
      $composableBuilder(column: $table.userUid, builder: (column) => column);

  GeneratedColumn<String> get notifictionToken => $composableBuilder(
    column: $table.notifictionToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceAccountUniqueKey => $composableBuilder(
    column: $table.deviceAccountUniqueKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceName => $composableBuilder(
    column: $table.deviceName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DeviceTokenDBTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeviceTokenDBTable,
          DeviceTokenDBData,
          $$DeviceTokenDBTableFilterComposer,
          $$DeviceTokenDBTableOrderingComposer,
          $$DeviceTokenDBTableAnnotationComposer,
          $$DeviceTokenDBTableCreateCompanionBuilder,
          $$DeviceTokenDBTableUpdateCompanionBuilder,
          (
            DeviceTokenDBData,
            BaseReferences<
              _$AppDatabase,
              $DeviceTokenDBTable,
              DeviceTokenDBData
            >,
          ),
          DeviceTokenDBData,
          PrefetchHooks Function()
        > {
  $$DeviceTokenDBTableTableManager(_$AppDatabase db, $DeviceTokenDBTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceTokenDBTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceTokenDBTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceTokenDBTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userUid = const Value.absent(),
                Value<String> notifictionToken = const Value.absent(),
                Value<String> deviceAccountUniqueKey = const Value.absent(),
                Value<String> deviceName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceTokenDBCompanion(
                userUid: userUid,
                notifictionToken: notifictionToken,
                deviceAccountUniqueKey: deviceAccountUniqueKey,
                deviceName: deviceName,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userUid,
                required String notifictionToken,
                required String deviceAccountUniqueKey,
                required String deviceName,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceTokenDBCompanion.insert(
                userUid: userUid,
                notifictionToken: notifictionToken,
                deviceAccountUniqueKey: deviceAccountUniqueKey,
                deviceName: deviceName,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeviceTokenDBTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeviceTokenDBTable,
      DeviceTokenDBData,
      $$DeviceTokenDBTableFilterComposer,
      $$DeviceTokenDBTableOrderingComposer,
      $$DeviceTokenDBTableAnnotationComposer,
      $$DeviceTokenDBTableCreateCompanionBuilder,
      $$DeviceTokenDBTableUpdateCompanionBuilder,
      (
        DeviceTokenDBData,
        BaseReferences<_$AppDatabase, $DeviceTokenDBTable, DeviceTokenDBData>,
      ),
      DeviceTokenDBData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AdditionalUserDataDBTableTableManager get additionalUserDataDB =>
      $$AdditionalUserDataDBTableTableManager(_db, _db.additionalUserDataDB);
  $$DeviceTokenDBTableTableManager get deviceTokenDB =>
      $$DeviceTokenDBTableTableManager(_db, _db.deviceTokenDB);
}
