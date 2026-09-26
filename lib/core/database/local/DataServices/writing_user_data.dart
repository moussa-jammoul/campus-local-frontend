// ignore_for_file: body_might_complete_normally_nullable, unused_local_variable

import 'package:drift/drift.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/db/main_db.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/web.dart';

class WritingUserData extends Notifier<void> {
  AppDatabase? db;
  late Logger logger;
  @override
  void build() {
    logger = ref.read(loggerProvider);
    db = ref.read(dbProvider);
  }

 
  Future<void> writeData(UserAdditionalData data) async {
  if (db != null) {
    logger.i('writing data locally: $data');
    try {
      await db!.into(db!.additionalUserDataDB).insertOnConflictUpdate(
        AdditionalUserDataDBCompanion.insert(
          uid: data.uid,
          email: data.email,
          fullname: data.fullname,
          dateOfBirth: data.dateOfBirth,
          role: data.role,
          major: data.major,
        ),
      );
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  } else {
    throw Error();
  }
}


  Future<UserAdditionalData?> readData(String uid) async {
  if (db != null) {
    final rawData = await (db!.select(db!.additionalUserDataDB)
          ..where((t) => t.uid.equals(uid)))
        .getSingleOrNull();

    if (rawData == null) return null;

    final data = UserAdditionalData(
      email: rawData.email,
      fullname: rawData.fullname,
      dateOfBirth: rawData.dateOfBirth,
      role: rawData.role,
      major: rawData.major,
      createdAt: rawData.createdAt,
      updatedAt: rawData.updatedAt,
      uid: rawData.uid,
    );
    return data;
  } else {
    return null;
  }
}

  Future<void> updateData(UserAdditionalData data) async{
    if(db != null){
      await (db!.update(db!.additionalUserDataDB)..where((t) => t.uid.equals(data.uid)  ))
                                .write(AdditionalUserDataDBCompanion(
                                   email: Value(data.email),
          fullname: Value(data.fullname),
          dateOfBirth: Value(data.dateOfBirth),
          role: Value(data.role),
          major: Value(data.major),
          updatedAt: Value(DateTime.now()),


                                ));
    }
    else{
      throw Error();
    }

  }

  Future<void> deleteData(String uid) async {
  if (db != null) {
    await (db!.delete(db!.additionalUserDataDB)..where((t) => t.uid.equals(uid)))
        .go();
  }
  }




}

final writingUserDataProvider = NotifierProvider<WritingUserData,void>((){
  return WritingUserData();
});