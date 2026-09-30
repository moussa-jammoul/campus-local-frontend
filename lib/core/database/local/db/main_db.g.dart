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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  Set<GeneratedColumn> get $primaryKey => {deviceAccountUniqueKey, userUid};
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
      ),
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
  final String? notifictionToken;
  final String deviceAccountUniqueKey;
  final String deviceName;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DeviceTokenDBData({
    required this.userUid,
    this.notifictionToken,
    required this.deviceAccountUniqueKey,
    required this.deviceName,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_uid'] = Variable<String>(userUid);
    if (!nullToAbsent || notifictionToken != null) {
      map['notifiction_token'] = Variable<String>(notifictionToken);
    }
    map['device_account_unique_key'] = Variable<String>(deviceAccountUniqueKey);
    map['device_name'] = Variable<String>(deviceName);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DeviceTokenDBCompanion toCompanion(bool nullToAbsent) {
    return DeviceTokenDBCompanion(
      userUid: Value(userUid),
      notifictionToken: notifictionToken == null && nullToAbsent
          ? const Value.absent()
          : Value(notifictionToken),
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
      notifictionToken: serializer.fromJson<String?>(json['notifictionToken']),
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
      'notifictionToken': serializer.toJson<String?>(notifictionToken),
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
    Value<String?> notifictionToken = const Value.absent(),
    String? deviceAccountUniqueKey,
    String? deviceName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DeviceTokenDBData(
    userUid: userUid ?? this.userUid,
    notifictionToken: notifictionToken.present
        ? notifictionToken.value
        : this.notifictionToken,
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
  final Value<String?> notifictionToken;
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
    this.notifictionToken = const Value.absent(),
    required String deviceAccountUniqueKey,
    required String deviceName,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userUid = Value(userUid),
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
    Value<String?>? notifictionToken,
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

class $SemesterDBTable extends SemesterDB
    with TableInfo<$SemesterDBTable, SemesterDBData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SemesterDBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v7(),
  );
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
  static const VerificationMeta _semesterNameMeta = const VerificationMeta(
    'semesterName',
  );
  @override
  late final GeneratedColumn<String> semesterName = GeneratedColumn<String>(
    'semester_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finishedOrYetMeta = const VerificationMeta(
    'finishedOrYet',
  );
  @override
  late final GeneratedColumn<bool> finishedOrYet = GeneratedColumn<bool>(
    'finished_or_yet',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("finished_or_yet" IN (0, 1))',
    ),
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
    id,
    uuid,
    userUid,
    semesterName,
    description,
    finishedOrYet,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'semester_d_b';
  @override
  VerificationContext validateIntegrity(
    Insertable<SemesterDBData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    }
    if (data.containsKey('user_uid')) {
      context.handle(
        _userUidMeta,
        userUid.isAcceptableOrUnknown(data['user_uid']!, _userUidMeta),
      );
    } else if (isInserting) {
      context.missing(_userUidMeta);
    }
    if (data.containsKey('semester_name')) {
      context.handle(
        _semesterNameMeta,
        semesterName.isAcceptableOrUnknown(
          data['semester_name']!,
          _semesterNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_semesterNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('finished_or_yet')) {
      context.handle(
        _finishedOrYetMeta,
        finishedOrYet.isAcceptableOrUnknown(
          data['finished_or_yet']!,
          _finishedOrYetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_finishedOrYetMeta);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SemesterDBData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SemesterDBData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      userUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_uid'],
      )!,
      semesterName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}semester_name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      finishedOrYet: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}finished_or_yet'],
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
  $SemesterDBTable createAlias(String alias) {
    return $SemesterDBTable(attachedDatabase, alias);
  }
}

class SemesterDBData extends DataClass implements Insertable<SemesterDBData> {
  final int id;
  final String uuid;
  final String userUid;
  final String semesterName;
  final String description;
  final bool finishedOrYet;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SemesterDBData({
    required this.id,
    required this.uuid,
    required this.userUid,
    required this.semesterName,
    required this.description,
    required this.finishedOrYet,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['user_uid'] = Variable<String>(userUid);
    map['semester_name'] = Variable<String>(semesterName);
    map['description'] = Variable<String>(description);
    map['finished_or_yet'] = Variable<bool>(finishedOrYet);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SemesterDBCompanion toCompanion(bool nullToAbsent) {
    return SemesterDBCompanion(
      id: Value(id),
      uuid: Value(uuid),
      userUid: Value(userUid),
      semesterName: Value(semesterName),
      description: Value(description),
      finishedOrYet: Value(finishedOrYet),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SemesterDBData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SemesterDBData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      userUid: serializer.fromJson<String>(json['userUid']),
      semesterName: serializer.fromJson<String>(json['semesterName']),
      description: serializer.fromJson<String>(json['description']),
      finishedOrYet: serializer.fromJson<bool>(json['finishedOrYet']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'userUid': serializer.toJson<String>(userUid),
      'semesterName': serializer.toJson<String>(semesterName),
      'description': serializer.toJson<String>(description),
      'finishedOrYet': serializer.toJson<bool>(finishedOrYet),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SemesterDBData copyWith({
    int? id,
    String? uuid,
    String? userUid,
    String? semesterName,
    String? description,
    bool? finishedOrYet,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SemesterDBData(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    userUid: userUid ?? this.userUid,
    semesterName: semesterName ?? this.semesterName,
    description: description ?? this.description,
    finishedOrYet: finishedOrYet ?? this.finishedOrYet,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SemesterDBData copyWithCompanion(SemesterDBCompanion data) {
    return SemesterDBData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      userUid: data.userUid.present ? data.userUid.value : this.userUid,
      semesterName: data.semesterName.present
          ? data.semesterName.value
          : this.semesterName,
      description: data.description.present
          ? data.description.value
          : this.description,
      finishedOrYet: data.finishedOrYet.present
          ? data.finishedOrYet.value
          : this.finishedOrYet,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SemesterDBData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userUid: $userUid, ')
          ..write('semesterName: $semesterName, ')
          ..write('description: $description, ')
          ..write('finishedOrYet: $finishedOrYet, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    userUid,
    semesterName,
    description,
    finishedOrYet,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SemesterDBData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.userUid == this.userUid &&
          other.semesterName == this.semesterName &&
          other.description == this.description &&
          other.finishedOrYet == this.finishedOrYet &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SemesterDBCompanion extends UpdateCompanion<SemesterDBData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> userUid;
  final Value<String> semesterName;
  final Value<String> description;
  final Value<bool> finishedOrYet;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SemesterDBCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.userUid = const Value.absent(),
    this.semesterName = const Value.absent(),
    this.description = const Value.absent(),
    this.finishedOrYet = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SemesterDBCompanion.insert({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    required String userUid,
    required String semesterName,
    required String description,
    required bool finishedOrYet,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : userUid = Value(userUid),
       semesterName = Value(semesterName),
       description = Value(description),
       finishedOrYet = Value(finishedOrYet);
  static Insertable<SemesterDBData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? userUid,
    Expression<String>? semesterName,
    Expression<String>? description,
    Expression<bool>? finishedOrYet,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (userUid != null) 'user_uid': userUid,
      if (semesterName != null) 'semester_name': semesterName,
      if (description != null) 'description': description,
      if (finishedOrYet != null) 'finished_or_yet': finishedOrYet,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SemesterDBCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? userUid,
    Value<String>? semesterName,
    Value<String>? description,
    Value<bool>? finishedOrYet,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SemesterDBCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userUid: userUid ?? this.userUid,
      semesterName: semesterName ?? this.semesterName,
      description: description ?? this.description,
      finishedOrYet: finishedOrYet ?? this.finishedOrYet,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (userUid.present) {
      map['user_uid'] = Variable<String>(userUid.value);
    }
    if (semesterName.present) {
      map['semester_name'] = Variable<String>(semesterName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (finishedOrYet.present) {
      map['finished_or_yet'] = Variable<bool>(finishedOrYet.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemesterDBCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userUid: $userUid, ')
          ..write('semesterName: $semesterName, ')
          ..write('description: $description, ')
          ..write('finishedOrYet: $finishedOrYet, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CourseDBTable extends CourseDB
    with TableInfo<$CourseDBTable, CourseDBData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CourseDBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v7(),
  );
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
  static const VerificationMeta _semesterUuidMeta = const VerificationMeta(
    'semesterUuid',
  );
  @override
  late final GeneratedColumn<String> semesterUuid = GeneratedColumn<String>(
    'semester_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseNameMeta = const VerificationMeta(
    'courseName',
  );
  @override
  late final GeneratedColumn<String> courseName = GeneratedColumn<String>(
    'course_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _professorNameMeta = const VerificationMeta(
    'professorName',
  );
  @override
  late final GeneratedColumn<String> professorName = GeneratedColumn<String>(
    'professor_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('doctor'),
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
    id,
    uuid,
    userUid,
    semesterUuid,
    courseName,
    description,
    professorName,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course_d_b';
  @override
  VerificationContext validateIntegrity(
    Insertable<CourseDBData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    }
    if (data.containsKey('user_uid')) {
      context.handle(
        _userUidMeta,
        userUid.isAcceptableOrUnknown(data['user_uid']!, _userUidMeta),
      );
    } else if (isInserting) {
      context.missing(_userUidMeta);
    }
    if (data.containsKey('semester_uuid')) {
      context.handle(
        _semesterUuidMeta,
        semesterUuid.isAcceptableOrUnknown(
          data['semester_uuid']!,
          _semesterUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_semesterUuidMeta);
    }
    if (data.containsKey('course_name')) {
      context.handle(
        _courseNameMeta,
        courseName.isAcceptableOrUnknown(data['course_name']!, _courseNameMeta),
      );
    } else if (isInserting) {
      context.missing(_courseNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('professor_name')) {
      context.handle(
        _professorNameMeta,
        professorName.isAcceptableOrUnknown(
          data['professor_name']!,
          _professorNameMeta,
        ),
      );
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CourseDBData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseDBData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      userUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_uid'],
      )!,
      semesterUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}semester_uuid'],
      )!,
      courseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      professorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}professor_name'],
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
  $CourseDBTable createAlias(String alias) {
    return $CourseDBTable(attachedDatabase, alias);
  }
}

class CourseDBData extends DataClass implements Insertable<CourseDBData> {
  final int id;
  final String uuid;
  final String userUid;
  final String semesterUuid;
  final String courseName;
  final String description;
  final String professorName;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CourseDBData({
    required this.id,
    required this.uuid,
    required this.userUid,
    required this.semesterUuid,
    required this.courseName,
    required this.description,
    required this.professorName,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['user_uid'] = Variable<String>(userUid);
    map['semester_uuid'] = Variable<String>(semesterUuid);
    map['course_name'] = Variable<String>(courseName);
    map['description'] = Variable<String>(description);
    map['professor_name'] = Variable<String>(professorName);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CourseDBCompanion toCompanion(bool nullToAbsent) {
    return CourseDBCompanion(
      id: Value(id),
      uuid: Value(uuid),
      userUid: Value(userUid),
      semesterUuid: Value(semesterUuid),
      courseName: Value(courseName),
      description: Value(description),
      professorName: Value(professorName),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CourseDBData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseDBData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      userUid: serializer.fromJson<String>(json['userUid']),
      semesterUuid: serializer.fromJson<String>(json['semesterUuid']),
      courseName: serializer.fromJson<String>(json['courseName']),
      description: serializer.fromJson<String>(json['description']),
      professorName: serializer.fromJson<String>(json['professorName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'userUid': serializer.toJson<String>(userUid),
      'semesterUuid': serializer.toJson<String>(semesterUuid),
      'courseName': serializer.toJson<String>(courseName),
      'description': serializer.toJson<String>(description),
      'professorName': serializer.toJson<String>(professorName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CourseDBData copyWith({
    int? id,
    String? uuid,
    String? userUid,
    String? semesterUuid,
    String? courseName,
    String? description,
    String? professorName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CourseDBData(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    userUid: userUid ?? this.userUid,
    semesterUuid: semesterUuid ?? this.semesterUuid,
    courseName: courseName ?? this.courseName,
    description: description ?? this.description,
    professorName: professorName ?? this.professorName,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CourseDBData copyWithCompanion(CourseDBCompanion data) {
    return CourseDBData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      userUid: data.userUid.present ? data.userUid.value : this.userUid,
      semesterUuid: data.semesterUuid.present
          ? data.semesterUuid.value
          : this.semesterUuid,
      courseName: data.courseName.present
          ? data.courseName.value
          : this.courseName,
      description: data.description.present
          ? data.description.value
          : this.description,
      professorName: data.professorName.present
          ? data.professorName.value
          : this.professorName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseDBData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userUid: $userUid, ')
          ..write('semesterUuid: $semesterUuid, ')
          ..write('courseName: $courseName, ')
          ..write('description: $description, ')
          ..write('professorName: $professorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    userUid,
    semesterUuid,
    courseName,
    description,
    professorName,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseDBData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.userUid == this.userUid &&
          other.semesterUuid == this.semesterUuid &&
          other.courseName == this.courseName &&
          other.description == this.description &&
          other.professorName == this.professorName &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CourseDBCompanion extends UpdateCompanion<CourseDBData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> userUid;
  final Value<String> semesterUuid;
  final Value<String> courseName;
  final Value<String> description;
  final Value<String> professorName;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CourseDBCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.userUid = const Value.absent(),
    this.semesterUuid = const Value.absent(),
    this.courseName = const Value.absent(),
    this.description = const Value.absent(),
    this.professorName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CourseDBCompanion.insert({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    required String userUid,
    required String semesterUuid,
    required String courseName,
    required String description,
    this.professorName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : userUid = Value(userUid),
       semesterUuid = Value(semesterUuid),
       courseName = Value(courseName),
       description = Value(description);
  static Insertable<CourseDBData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? userUid,
    Expression<String>? semesterUuid,
    Expression<String>? courseName,
    Expression<String>? description,
    Expression<String>? professorName,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (userUid != null) 'user_uid': userUid,
      if (semesterUuid != null) 'semester_uuid': semesterUuid,
      if (courseName != null) 'course_name': courseName,
      if (description != null) 'description': description,
      if (professorName != null) 'professor_name': professorName,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CourseDBCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? userUid,
    Value<String>? semesterUuid,
    Value<String>? courseName,
    Value<String>? description,
    Value<String>? professorName,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CourseDBCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userUid: userUid ?? this.userUid,
      semesterUuid: semesterUuid ?? this.semesterUuid,
      courseName: courseName ?? this.courseName,
      description: description ?? this.description,
      professorName: professorName ?? this.professorName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (userUid.present) {
      map['user_uid'] = Variable<String>(userUid.value);
    }
    if (semesterUuid.present) {
      map['semester_uuid'] = Variable<String>(semesterUuid.value);
    }
    if (courseName.present) {
      map['course_name'] = Variable<String>(courseName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (professorName.present) {
      map['professor_name'] = Variable<String>(professorName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CourseDBCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userUid: $userUid, ')
          ..write('semesterUuid: $semesterUuid, ')
          ..write('courseName: $courseName, ')
          ..write('description: $description, ')
          ..write('professorName: $professorName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DeadLineDBTable extends DeadLineDB
    with TableInfo<$DeadLineDBTable, DeadLineDBData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeadLineDBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v7(),
  );
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
  static const VerificationMeta _mediaUuidMeta = const VerificationMeta(
    'mediaUuid',
  );
  @override
  late final GeneratedColumn<String> mediaUuid = GeneratedColumn<String>(
    'media_uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notifiedMeta = const VerificationMeta(
    'notified',
  );
  @override
  late final GeneratedColumn<bool> notified = GeneratedColumn<bool>(
    'notified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notified" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    userUid,
    mediaUuid,
    dueAt,
    title,
    description,
    notified,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dead_line_d_b';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeadLineDBData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    }
    if (data.containsKey('user_uid')) {
      context.handle(
        _userUidMeta,
        userUid.isAcceptableOrUnknown(data['user_uid']!, _userUidMeta),
      );
    } else if (isInserting) {
      context.missing(_userUidMeta);
    }
    if (data.containsKey('media_uuid')) {
      context.handle(
        _mediaUuidMeta,
        mediaUuid.isAcceptableOrUnknown(data['media_uuid']!, _mediaUuidMeta),
      );
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    } else if (isInserting) {
      context.missing(_dueAtMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('notified')) {
      context.handle(
        _notifiedMeta,
        notified.isAcceptableOrUnknown(data['notified']!, _notifiedMeta),
      );
    } else if (isInserting) {
      context.missing(_notifiedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeadLineDBData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeadLineDBData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      userUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_uid'],
      )!,
      mediaUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_uuid'],
      ),
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      notified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notified'],
      )!,
    );
  }

  @override
  $DeadLineDBTable createAlias(String alias) {
    return $DeadLineDBTable(attachedDatabase, alias);
  }
}

class DeadLineDBData extends DataClass implements Insertable<DeadLineDBData> {
  final int id;
  final String uuid;
  final String userUid;
  final String? mediaUuid;
  final DateTime dueAt;
  final String title;
  final String description;
  final bool notified;
  const DeadLineDBData({
    required this.id,
    required this.uuid,
    required this.userUid,
    this.mediaUuid,
    required this.dueAt,
    required this.title,
    required this.description,
    required this.notified,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['user_uid'] = Variable<String>(userUid);
    if (!nullToAbsent || mediaUuid != null) {
      map['media_uuid'] = Variable<String>(mediaUuid);
    }
    map['due_at'] = Variable<DateTime>(dueAt);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['notified'] = Variable<bool>(notified);
    return map;
  }

  DeadLineDBCompanion toCompanion(bool nullToAbsent) {
    return DeadLineDBCompanion(
      id: Value(id),
      uuid: Value(uuid),
      userUid: Value(userUid),
      mediaUuid: mediaUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaUuid),
      dueAt: Value(dueAt),
      title: Value(title),
      description: Value(description),
      notified: Value(notified),
    );
  }

  factory DeadLineDBData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeadLineDBData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      userUid: serializer.fromJson<String>(json['userUid']),
      mediaUuid: serializer.fromJson<String?>(json['mediaUuid']),
      dueAt: serializer.fromJson<DateTime>(json['dueAt']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      notified: serializer.fromJson<bool>(json['notified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'userUid': serializer.toJson<String>(userUid),
      'mediaUuid': serializer.toJson<String?>(mediaUuid),
      'dueAt': serializer.toJson<DateTime>(dueAt),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'notified': serializer.toJson<bool>(notified),
    };
  }

  DeadLineDBData copyWith({
    int? id,
    String? uuid,
    String? userUid,
    Value<String?> mediaUuid = const Value.absent(),
    DateTime? dueAt,
    String? title,
    String? description,
    bool? notified,
  }) => DeadLineDBData(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    userUid: userUid ?? this.userUid,
    mediaUuid: mediaUuid.present ? mediaUuid.value : this.mediaUuid,
    dueAt: dueAt ?? this.dueAt,
    title: title ?? this.title,
    description: description ?? this.description,
    notified: notified ?? this.notified,
  );
  DeadLineDBData copyWithCompanion(DeadLineDBCompanion data) {
    return DeadLineDBData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      userUid: data.userUid.present ? data.userUid.value : this.userUid,
      mediaUuid: data.mediaUuid.present ? data.mediaUuid.value : this.mediaUuid,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      notified: data.notified.present ? data.notified.value : this.notified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeadLineDBData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userUid: $userUid, ')
          ..write('mediaUuid: $mediaUuid, ')
          ..write('dueAt: $dueAt, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('notified: $notified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    userUid,
    mediaUuid,
    dueAt,
    title,
    description,
    notified,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeadLineDBData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.userUid == this.userUid &&
          other.mediaUuid == this.mediaUuid &&
          other.dueAt == this.dueAt &&
          other.title == this.title &&
          other.description == this.description &&
          other.notified == this.notified);
}

class DeadLineDBCompanion extends UpdateCompanion<DeadLineDBData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> userUid;
  final Value<String?> mediaUuid;
  final Value<DateTime> dueAt;
  final Value<String> title;
  final Value<String> description;
  final Value<bool> notified;
  const DeadLineDBCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.userUid = const Value.absent(),
    this.mediaUuid = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.notified = const Value.absent(),
  });
  DeadLineDBCompanion.insert({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    required String userUid,
    this.mediaUuid = const Value.absent(),
    required DateTime dueAt,
    required String title,
    required String description,
    required bool notified,
  }) : userUid = Value(userUid),
       dueAt = Value(dueAt),
       title = Value(title),
       description = Value(description),
       notified = Value(notified);
  static Insertable<DeadLineDBData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? userUid,
    Expression<String>? mediaUuid,
    Expression<DateTime>? dueAt,
    Expression<String>? title,
    Expression<String>? description,
    Expression<bool>? notified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (userUid != null) 'user_uid': userUid,
      if (mediaUuid != null) 'media_uuid': mediaUuid,
      if (dueAt != null) 'due_at': dueAt,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (notified != null) 'notified': notified,
    });
  }

  DeadLineDBCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? userUid,
    Value<String?>? mediaUuid,
    Value<DateTime>? dueAt,
    Value<String>? title,
    Value<String>? description,
    Value<bool>? notified,
  }) {
    return DeadLineDBCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userUid: userUid ?? this.userUid,
      mediaUuid: mediaUuid ?? this.mediaUuid,
      dueAt: dueAt ?? this.dueAt,
      title: title ?? this.title,
      description: description ?? this.description,
      notified: notified ?? this.notified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (userUid.present) {
      map['user_uid'] = Variable<String>(userUid.value);
    }
    if (mediaUuid.present) {
      map['media_uuid'] = Variable<String>(mediaUuid.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (notified.present) {
      map['notified'] = Variable<bool>(notified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeadLineDBCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userUid: $userUid, ')
          ..write('mediaUuid: $mediaUuid, ')
          ..write('dueAt: $dueAt, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('notified: $notified')
          ..write(')'))
        .toString();
  }
}

class $MediaDBTable extends MediaDB with TableInfo<$MediaDBTable, MediaDBData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaDBTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v7(),
  );
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
  static const VerificationMeta _courseUuidMeta = const VerificationMeta(
    'courseUuid',
  );
  @override
  late final GeneratedColumn<String> courseUuid = GeneratedColumn<String>(
    'course_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileDescriptionMeta = const VerificationMeta(
    'fileDescription',
  );
  @override
  late final GeneratedColumn<String> fileDescription = GeneratedColumn<String>(
    'file_description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileTypeMeta = const VerificationMeta(
    'fileType',
  );
  @override
  late final GeneratedColumn<String> fileType = GeneratedColumn<String>(
    'file_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeByteMeta = const VerificationMeta(
    'fileSizeByte',
  );
  @override
  late final GeneratedColumn<int> fileSizeByte = GeneratedColumn<int>(
    'file_size_byte',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    id,
    uuid,
    userUid,
    courseUuid,
    fileName,
    fileDescription,
    filePath,
    fileType,
    fileSizeByte,
    isFavorite,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_d_b';
  @override
  VerificationContext validateIntegrity(
    Insertable<MediaDBData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    }
    if (data.containsKey('user_uid')) {
      context.handle(
        _userUidMeta,
        userUid.isAcceptableOrUnknown(data['user_uid']!, _userUidMeta),
      );
    } else if (isInserting) {
      context.missing(_userUidMeta);
    }
    if (data.containsKey('course_uuid')) {
      context.handle(
        _courseUuidMeta,
        courseUuid.isAcceptableOrUnknown(data['course_uuid']!, _courseUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_courseUuidMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_description')) {
      context.handle(
        _fileDescriptionMeta,
        fileDescription.isAcceptableOrUnknown(
          data['file_description']!,
          _fileDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('file_type')) {
      context.handle(
        _fileTypeMeta,
        fileType.isAcceptableOrUnknown(data['file_type']!, _fileTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileTypeMeta);
    }
    if (data.containsKey('file_size_byte')) {
      context.handle(
        _fileSizeByteMeta,
        fileSizeByte.isAcceptableOrUnknown(
          data['file_size_byte']!,
          _fileSizeByteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fileSizeByteMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaDBData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaDBData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      userUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_uid'],
      )!,
      courseUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}course_uuid'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      fileDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_description'],
      ),
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      fileType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_type'],
      )!,
      fileSizeByte: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size_byte'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
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
  $MediaDBTable createAlias(String alias) {
    return $MediaDBTable(attachedDatabase, alias);
  }
}

class MediaDBData extends DataClass implements Insertable<MediaDBData> {
  final int id;
  final String uuid;
  final String userUid;
  final String courseUuid;
  final String fileName;
  final String? fileDescription;
  final String filePath;
  final String fileType;
  final int fileSizeByte;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MediaDBData({
    required this.id,
    required this.uuid,
    required this.userUid,
    required this.courseUuid,
    required this.fileName,
    this.fileDescription,
    required this.filePath,
    required this.fileType,
    required this.fileSizeByte,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['user_uid'] = Variable<String>(userUid);
    map['course_uuid'] = Variable<String>(courseUuid);
    map['file_name'] = Variable<String>(fileName);
    if (!nullToAbsent || fileDescription != null) {
      map['file_description'] = Variable<String>(fileDescription);
    }
    map['file_path'] = Variable<String>(filePath);
    map['file_type'] = Variable<String>(fileType);
    map['file_size_byte'] = Variable<int>(fileSizeByte);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MediaDBCompanion toCompanion(bool nullToAbsent) {
    return MediaDBCompanion(
      id: Value(id),
      uuid: Value(uuid),
      userUid: Value(userUid),
      courseUuid: Value(courseUuid),
      fileName: Value(fileName),
      fileDescription: fileDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(fileDescription),
      filePath: Value(filePath),
      fileType: Value(fileType),
      fileSizeByte: Value(fileSizeByte),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MediaDBData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaDBData(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      userUid: serializer.fromJson<String>(json['userUid']),
      courseUuid: serializer.fromJson<String>(json['courseUuid']),
      fileName: serializer.fromJson<String>(json['fileName']),
      fileDescription: serializer.fromJson<String?>(json['fileDescription']),
      filePath: serializer.fromJson<String>(json['filePath']),
      fileType: serializer.fromJson<String>(json['fileType']),
      fileSizeByte: serializer.fromJson<int>(json['fileSizeByte']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String>(uuid),
      'userUid': serializer.toJson<String>(userUid),
      'courseUuid': serializer.toJson<String>(courseUuid),
      'fileName': serializer.toJson<String>(fileName),
      'fileDescription': serializer.toJson<String?>(fileDescription),
      'filePath': serializer.toJson<String>(filePath),
      'fileType': serializer.toJson<String>(fileType),
      'fileSizeByte': serializer.toJson<int>(fileSizeByte),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MediaDBData copyWith({
    int? id,
    String? uuid,
    String? userUid,
    String? courseUuid,
    String? fileName,
    Value<String?> fileDescription = const Value.absent(),
    String? filePath,
    String? fileType,
    int? fileSizeByte,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MediaDBData(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    userUid: userUid ?? this.userUid,
    courseUuid: courseUuid ?? this.courseUuid,
    fileName: fileName ?? this.fileName,
    fileDescription: fileDescription.present
        ? fileDescription.value
        : this.fileDescription,
    filePath: filePath ?? this.filePath,
    fileType: fileType ?? this.fileType,
    fileSizeByte: fileSizeByte ?? this.fileSizeByte,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MediaDBData copyWithCompanion(MediaDBCompanion data) {
    return MediaDBData(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      userUid: data.userUid.present ? data.userUid.value : this.userUid,
      courseUuid: data.courseUuid.present
          ? data.courseUuid.value
          : this.courseUuid,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      fileDescription: data.fileDescription.present
          ? data.fileDescription.value
          : this.fileDescription,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      fileType: data.fileType.present ? data.fileType.value : this.fileType,
      fileSizeByte: data.fileSizeByte.present
          ? data.fileSizeByte.value
          : this.fileSizeByte,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaDBData(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userUid: $userUid, ')
          ..write('courseUuid: $courseUuid, ')
          ..write('fileName: $fileName, ')
          ..write('fileDescription: $fileDescription, ')
          ..write('filePath: $filePath, ')
          ..write('fileType: $fileType, ')
          ..write('fileSizeByte: $fileSizeByte, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    userUid,
    courseUuid,
    fileName,
    fileDescription,
    filePath,
    fileType,
    fileSizeByte,
    isFavorite,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaDBData &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.userUid == this.userUid &&
          other.courseUuid == this.courseUuid &&
          other.fileName == this.fileName &&
          other.fileDescription == this.fileDescription &&
          other.filePath == this.filePath &&
          other.fileType == this.fileType &&
          other.fileSizeByte == this.fileSizeByte &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MediaDBCompanion extends UpdateCompanion<MediaDBData> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> userUid;
  final Value<String> courseUuid;
  final Value<String> fileName;
  final Value<String?> fileDescription;
  final Value<String> filePath;
  final Value<String> fileType;
  final Value<int> fileSizeByte;
  final Value<bool> isFavorite;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MediaDBCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.userUid = const Value.absent(),
    this.courseUuid = const Value.absent(),
    this.fileName = const Value.absent(),
    this.fileDescription = const Value.absent(),
    this.filePath = const Value.absent(),
    this.fileType = const Value.absent(),
    this.fileSizeByte = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MediaDBCompanion.insert({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    required String userUid,
    required String courseUuid,
    required String fileName,
    this.fileDescription = const Value.absent(),
    required String filePath,
    required String fileType,
    required int fileSizeByte,
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : userUid = Value(userUid),
       courseUuid = Value(courseUuid),
       fileName = Value(fileName),
       filePath = Value(filePath),
       fileType = Value(fileType),
       fileSizeByte = Value(fileSizeByte);
  static Insertable<MediaDBData> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? userUid,
    Expression<String>? courseUuid,
    Expression<String>? fileName,
    Expression<String>? fileDescription,
    Expression<String>? filePath,
    Expression<String>? fileType,
    Expression<int>? fileSizeByte,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (userUid != null) 'user_uid': userUid,
      if (courseUuid != null) 'course_uuid': courseUuid,
      if (fileName != null) 'file_name': fileName,
      if (fileDescription != null) 'file_description': fileDescription,
      if (filePath != null) 'file_path': filePath,
      if (fileType != null) 'file_type': fileType,
      if (fileSizeByte != null) 'file_size_byte': fileSizeByte,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MediaDBCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? userUid,
    Value<String>? courseUuid,
    Value<String>? fileName,
    Value<String?>? fileDescription,
    Value<String>? filePath,
    Value<String>? fileType,
    Value<int>? fileSizeByte,
    Value<bool>? isFavorite,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MediaDBCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userUid: userUid ?? this.userUid,
      courseUuid: courseUuid ?? this.courseUuid,
      fileName: fileName ?? this.fileName,
      fileDescription: fileDescription ?? this.fileDescription,
      filePath: filePath ?? this.filePath,
      fileType: fileType ?? this.fileType,
      fileSizeByte: fileSizeByte ?? this.fileSizeByte,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (userUid.present) {
      map['user_uid'] = Variable<String>(userUid.value);
    }
    if (courseUuid.present) {
      map['course_uuid'] = Variable<String>(courseUuid.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (fileDescription.present) {
      map['file_description'] = Variable<String>(fileDescription.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (fileType.present) {
      map['file_type'] = Variable<String>(fileType.value);
    }
    if (fileSizeByte.present) {
      map['file_size_byte'] = Variable<int>(fileSizeByte.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaDBCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('userUid: $userUid, ')
          ..write('courseUuid: $courseUuid, ')
          ..write('fileName: $fileName, ')
          ..write('fileDescription: $fileDescription, ')
          ..write('filePath: $filePath, ')
          ..write('fileType: $fileType, ')
          ..write('fileSizeByte: $fileSizeByte, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
  late final $SemesterDBTable semesterDB = $SemesterDBTable(this);
  late final $CourseDBTable courseDB = $CourseDBTable(this);
  late final $DeadLineDBTable deadLineDB = $DeadLineDBTable(this);
  late final $MediaDBTable mediaDB = $MediaDBTable(this);
  late final Index idxCourseSemesterUuid = Index(
    'idx_course_semester_uuid',
    'CREATE INDEX idx_course_semester_uuid ON course_d_b (semester_uuid)',
  );
  late final Index idxDeadlineMediaUuid = Index(
    'idx_deadline_media_uuid',
    'CREATE INDEX idx_deadline_media_uuid ON dead_line_d_b (media_uuid)',
  );
  late final Index idxMediaCourseUuid = Index(
    'idx_media_course_uuid',
    'CREATE INDEX idx_media_course_uuid ON media_d_b (course_uuid)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    additionalUserDataDB,
    deviceTokenDB,
    semesterDB,
    courseDB,
    deadLineDB,
    mediaDB,
    idxCourseSemesterUuid,
    idxDeadlineMediaUuid,
    idxMediaCourseUuid,
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
      Value<String?> notifictionToken,
      required String deviceAccountUniqueKey,
      required String deviceName,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$DeviceTokenDBTableUpdateCompanionBuilder =
    DeviceTokenDBCompanion Function({
      Value<String> userUid,
      Value<String?> notifictionToken,
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
                Value<String?> notifictionToken = const Value.absent(),
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
                Value<String?> notifictionToken = const Value.absent(),
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
typedef $$SemesterDBTableCreateCompanionBuilder =
    SemesterDBCompanion Function({
      Value<int> id,
      Value<String> uuid,
      required String userUid,
      required String semesterName,
      required String description,
      required bool finishedOrYet,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$SemesterDBTableUpdateCompanionBuilder =
    SemesterDBCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> userUid,
      Value<String> semesterName,
      Value<String> description,
      Value<bool> finishedOrYet,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$SemesterDBTableFilterComposer
    extends Composer<_$AppDatabase, $SemesterDBTable> {
  $$SemesterDBTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userUid => $composableBuilder(
    column: $table.userUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get semesterName => $composableBuilder(
    column: $table.semesterName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get finishedOrYet => $composableBuilder(
    column: $table.finishedOrYet,
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

class $$SemesterDBTableOrderingComposer
    extends Composer<_$AppDatabase, $SemesterDBTable> {
  $$SemesterDBTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userUid => $composableBuilder(
    column: $table.userUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get semesterName => $composableBuilder(
    column: $table.semesterName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get finishedOrYet => $composableBuilder(
    column: $table.finishedOrYet,
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

class $$SemesterDBTableAnnotationComposer
    extends Composer<_$AppDatabase, $SemesterDBTable> {
  $$SemesterDBTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get userUid =>
      $composableBuilder(column: $table.userUid, builder: (column) => column);

  GeneratedColumn<String> get semesterName => $composableBuilder(
    column: $table.semesterName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get finishedOrYet => $composableBuilder(
    column: $table.finishedOrYet,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SemesterDBTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SemesterDBTable,
          SemesterDBData,
          $$SemesterDBTableFilterComposer,
          $$SemesterDBTableOrderingComposer,
          $$SemesterDBTableAnnotationComposer,
          $$SemesterDBTableCreateCompanionBuilder,
          $$SemesterDBTableUpdateCompanionBuilder,
          (
            SemesterDBData,
            BaseReferences<_$AppDatabase, $SemesterDBTable, SemesterDBData>,
          ),
          SemesterDBData,
          PrefetchHooks Function()
        > {
  $$SemesterDBTableTableManager(_$AppDatabase db, $SemesterDBTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SemesterDBTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SemesterDBTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SemesterDBTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> userUid = const Value.absent(),
                Value<String> semesterName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<bool> finishedOrYet = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SemesterDBCompanion(
                id: id,
                uuid: uuid,
                userUid: userUid,
                semesterName: semesterName,
                description: description,
                finishedOrYet: finishedOrYet,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                required String userUid,
                required String semesterName,
                required String description,
                required bool finishedOrYet,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SemesterDBCompanion.insert(
                id: id,
                uuid: uuid,
                userUid: userUid,
                semesterName: semesterName,
                description: description,
                finishedOrYet: finishedOrYet,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SemesterDBTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SemesterDBTable,
      SemesterDBData,
      $$SemesterDBTableFilterComposer,
      $$SemesterDBTableOrderingComposer,
      $$SemesterDBTableAnnotationComposer,
      $$SemesterDBTableCreateCompanionBuilder,
      $$SemesterDBTableUpdateCompanionBuilder,
      (
        SemesterDBData,
        BaseReferences<_$AppDatabase, $SemesterDBTable, SemesterDBData>,
      ),
      SemesterDBData,
      PrefetchHooks Function()
    >;
typedef $$CourseDBTableCreateCompanionBuilder =
    CourseDBCompanion Function({
      Value<int> id,
      Value<String> uuid,
      required String userUid,
      required String semesterUuid,
      required String courseName,
      required String description,
      Value<String> professorName,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CourseDBTableUpdateCompanionBuilder =
    CourseDBCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> userUid,
      Value<String> semesterUuid,
      Value<String> courseName,
      Value<String> description,
      Value<String> professorName,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$CourseDBTableFilterComposer
    extends Composer<_$AppDatabase, $CourseDBTable> {
  $$CourseDBTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userUid => $composableBuilder(
    column: $table.userUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get semesterUuid => $composableBuilder(
    column: $table.semesterUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get professorName => $composableBuilder(
    column: $table.professorName,
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

class $$CourseDBTableOrderingComposer
    extends Composer<_$AppDatabase, $CourseDBTable> {
  $$CourseDBTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userUid => $composableBuilder(
    column: $table.userUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get semesterUuid => $composableBuilder(
    column: $table.semesterUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get professorName => $composableBuilder(
    column: $table.professorName,
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

class $$CourseDBTableAnnotationComposer
    extends Composer<_$AppDatabase, $CourseDBTable> {
  $$CourseDBTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get userUid =>
      $composableBuilder(column: $table.userUid, builder: (column) => column);

  GeneratedColumn<String> get semesterUuid => $composableBuilder(
    column: $table.semesterUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseName => $composableBuilder(
    column: $table.courseName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get professorName => $composableBuilder(
    column: $table.professorName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CourseDBTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CourseDBTable,
          CourseDBData,
          $$CourseDBTableFilterComposer,
          $$CourseDBTableOrderingComposer,
          $$CourseDBTableAnnotationComposer,
          $$CourseDBTableCreateCompanionBuilder,
          $$CourseDBTableUpdateCompanionBuilder,
          (
            CourseDBData,
            BaseReferences<_$AppDatabase, $CourseDBTable, CourseDBData>,
          ),
          CourseDBData,
          PrefetchHooks Function()
        > {
  $$CourseDBTableTableManager(_$AppDatabase db, $CourseDBTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CourseDBTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CourseDBTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CourseDBTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> userUid = const Value.absent(),
                Value<String> semesterUuid = const Value.absent(),
                Value<String> courseName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> professorName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CourseDBCompanion(
                id: id,
                uuid: uuid,
                userUid: userUid,
                semesterUuid: semesterUuid,
                courseName: courseName,
                description: description,
                professorName: professorName,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                required String userUid,
                required String semesterUuid,
                required String courseName,
                required String description,
                Value<String> professorName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CourseDBCompanion.insert(
                id: id,
                uuid: uuid,
                userUid: userUid,
                semesterUuid: semesterUuid,
                courseName: courseName,
                description: description,
                professorName: professorName,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CourseDBTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CourseDBTable,
      CourseDBData,
      $$CourseDBTableFilterComposer,
      $$CourseDBTableOrderingComposer,
      $$CourseDBTableAnnotationComposer,
      $$CourseDBTableCreateCompanionBuilder,
      $$CourseDBTableUpdateCompanionBuilder,
      (
        CourseDBData,
        BaseReferences<_$AppDatabase, $CourseDBTable, CourseDBData>,
      ),
      CourseDBData,
      PrefetchHooks Function()
    >;
typedef $$DeadLineDBTableCreateCompanionBuilder =
    DeadLineDBCompanion Function({
      Value<int> id,
      Value<String> uuid,
      required String userUid,
      Value<String?> mediaUuid,
      required DateTime dueAt,
      required String title,
      required String description,
      required bool notified,
    });
typedef $$DeadLineDBTableUpdateCompanionBuilder =
    DeadLineDBCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> userUid,
      Value<String?> mediaUuid,
      Value<DateTime> dueAt,
      Value<String> title,
      Value<String> description,
      Value<bool> notified,
    });

class $$DeadLineDBTableFilterComposer
    extends Composer<_$AppDatabase, $DeadLineDBTable> {
  $$DeadLineDBTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userUid => $composableBuilder(
    column: $table.userUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mediaUuid => $composableBuilder(
    column: $table.mediaUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notified => $composableBuilder(
    column: $table.notified,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeadLineDBTableOrderingComposer
    extends Composer<_$AppDatabase, $DeadLineDBTable> {
  $$DeadLineDBTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userUid => $composableBuilder(
    column: $table.userUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaUuid => $composableBuilder(
    column: $table.mediaUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notified => $composableBuilder(
    column: $table.notified,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeadLineDBTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeadLineDBTable> {
  $$DeadLineDBTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get userUid =>
      $composableBuilder(column: $table.userUid, builder: (column) => column);

  GeneratedColumn<String> get mediaUuid =>
      $composableBuilder(column: $table.mediaUuid, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notified =>
      $composableBuilder(column: $table.notified, builder: (column) => column);
}

class $$DeadLineDBTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeadLineDBTable,
          DeadLineDBData,
          $$DeadLineDBTableFilterComposer,
          $$DeadLineDBTableOrderingComposer,
          $$DeadLineDBTableAnnotationComposer,
          $$DeadLineDBTableCreateCompanionBuilder,
          $$DeadLineDBTableUpdateCompanionBuilder,
          (
            DeadLineDBData,
            BaseReferences<_$AppDatabase, $DeadLineDBTable, DeadLineDBData>,
          ),
          DeadLineDBData,
          PrefetchHooks Function()
        > {
  $$DeadLineDBTableTableManager(_$AppDatabase db, $DeadLineDBTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeadLineDBTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeadLineDBTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeadLineDBTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> userUid = const Value.absent(),
                Value<String?> mediaUuid = const Value.absent(),
                Value<DateTime> dueAt = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<bool> notified = const Value.absent(),
              }) => DeadLineDBCompanion(
                id: id,
                uuid: uuid,
                userUid: userUid,
                mediaUuid: mediaUuid,
                dueAt: dueAt,
                title: title,
                description: description,
                notified: notified,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                required String userUid,
                Value<String?> mediaUuid = const Value.absent(),
                required DateTime dueAt,
                required String title,
                required String description,
                required bool notified,
              }) => DeadLineDBCompanion.insert(
                id: id,
                uuid: uuid,
                userUid: userUid,
                mediaUuid: mediaUuid,
                dueAt: dueAt,
                title: title,
                description: description,
                notified: notified,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeadLineDBTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeadLineDBTable,
      DeadLineDBData,
      $$DeadLineDBTableFilterComposer,
      $$DeadLineDBTableOrderingComposer,
      $$DeadLineDBTableAnnotationComposer,
      $$DeadLineDBTableCreateCompanionBuilder,
      $$DeadLineDBTableUpdateCompanionBuilder,
      (
        DeadLineDBData,
        BaseReferences<_$AppDatabase, $DeadLineDBTable, DeadLineDBData>,
      ),
      DeadLineDBData,
      PrefetchHooks Function()
    >;
typedef $$MediaDBTableCreateCompanionBuilder =
    MediaDBCompanion Function({
      Value<int> id,
      Value<String> uuid,
      required String userUid,
      required String courseUuid,
      required String fileName,
      Value<String?> fileDescription,
      required String filePath,
      required String fileType,
      required int fileSizeByte,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$MediaDBTableUpdateCompanionBuilder =
    MediaDBCompanion Function({
      Value<int> id,
      Value<String> uuid,
      Value<String> userUid,
      Value<String> courseUuid,
      Value<String> fileName,
      Value<String?> fileDescription,
      Value<String> filePath,
      Value<String> fileType,
      Value<int> fileSizeByte,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$MediaDBTableFilterComposer
    extends Composer<_$AppDatabase, $MediaDBTable> {
  $$MediaDBTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userUid => $composableBuilder(
    column: $table.userUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseUuid => $composableBuilder(
    column: $table.courseUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileDescription => $composableBuilder(
    column: $table.fileDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSizeByte => $composableBuilder(
    column: $table.fileSizeByte,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
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

class $$MediaDBTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaDBTable> {
  $$MediaDBTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userUid => $composableBuilder(
    column: $table.userUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseUuid => $composableBuilder(
    column: $table.courseUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileDescription => $composableBuilder(
    column: $table.fileDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileType => $composableBuilder(
    column: $table.fileType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSizeByte => $composableBuilder(
    column: $table.fileSizeByte,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
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

class $$MediaDBTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaDBTable> {
  $$MediaDBTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get userUid =>
      $composableBuilder(column: $table.userUid, builder: (column) => column);

  GeneratedColumn<String> get courseUuid => $composableBuilder(
    column: $table.courseUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get fileDescription => $composableBuilder(
    column: $table.fileDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get fileType =>
      $composableBuilder(column: $table.fileType, builder: (column) => column);

  GeneratedColumn<int> get fileSizeByte => $composableBuilder(
    column: $table.fileSizeByte,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MediaDBTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MediaDBTable,
          MediaDBData,
          $$MediaDBTableFilterComposer,
          $$MediaDBTableOrderingComposer,
          $$MediaDBTableAnnotationComposer,
          $$MediaDBTableCreateCompanionBuilder,
          $$MediaDBTableUpdateCompanionBuilder,
          (
            MediaDBData,
            BaseReferences<_$AppDatabase, $MediaDBTable, MediaDBData>,
          ),
          MediaDBData,
          PrefetchHooks Function()
        > {
  $$MediaDBTableTableManager(_$AppDatabase db, $MediaDBTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaDBTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaDBTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaDBTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> userUid = const Value.absent(),
                Value<String> courseUuid = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<String?> fileDescription = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String> fileType = const Value.absent(),
                Value<int> fileSizeByte = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MediaDBCompanion(
                id: id,
                uuid: uuid,
                userUid: userUid,
                courseUuid: courseUuid,
                fileName: fileName,
                fileDescription: fileDescription,
                filePath: filePath,
                fileType: fileType,
                fileSizeByte: fileSizeByte,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                required String userUid,
                required String courseUuid,
                required String fileName,
                Value<String?> fileDescription = const Value.absent(),
                required String filePath,
                required String fileType,
                required int fileSizeByte,
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MediaDBCompanion.insert(
                id: id,
                uuid: uuid,
                userUid: userUid,
                courseUuid: courseUuid,
                fileName: fileName,
                fileDescription: fileDescription,
                filePath: filePath,
                fileType: fileType,
                fileSizeByte: fileSizeByte,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MediaDBTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MediaDBTable,
      MediaDBData,
      $$MediaDBTableFilterComposer,
      $$MediaDBTableOrderingComposer,
      $$MediaDBTableAnnotationComposer,
      $$MediaDBTableCreateCompanionBuilder,
      $$MediaDBTableUpdateCompanionBuilder,
      (MediaDBData, BaseReferences<_$AppDatabase, $MediaDBTable, MediaDBData>),
      MediaDBData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AdditionalUserDataDBTableTableManager get additionalUserDataDB =>
      $$AdditionalUserDataDBTableTableManager(_db, _db.additionalUserDataDB);
  $$DeviceTokenDBTableTableManager get deviceTokenDB =>
      $$DeviceTokenDBTableTableManager(_db, _db.deviceTokenDB);
  $$SemesterDBTableTableManager get semesterDB =>
      $$SemesterDBTableTableManager(_db, _db.semesterDB);
  $$CourseDBTableTableManager get courseDB =>
      $$CourseDBTableTableManager(_db, _db.courseDB);
  $$DeadLineDBTableTableManager get deadLineDB =>
      $$DeadLineDBTableTableManager(_db, _db.deadLineDB);
  $$MediaDBTableTableManager get mediaDB =>
      $$MediaDBTableTableManager(_db, _db.mediaDB);
}
