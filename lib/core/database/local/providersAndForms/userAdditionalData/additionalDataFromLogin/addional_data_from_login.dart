import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_user_data.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:logger/web.dart';


///this riverpod is used to handle the additional data user inserted 
///at the log in , and wiring it to the local db , why we need it instead of injecting the data too firestore
///immedialty after  login ? because we won't create anything until user verify 
///his email , after email verification , function that live in /router/functions_after_succes_clean_login.dart
///will handle using those data to inject them to firestore (if the data is missed entirely , we ask the user 
///to complete the form again), plus ui will read directly from it (local first application :) )
class AddionalDataFromLogin extends Notifier<UserAdditionalData?> {
  late Logger logger;

  @override
  UserAdditionalData? build() {
    logger = ref.read(loggerProvider);
    return null;
  }

  ///we handle here wiring the data to the memory and local db
  Future<void> readData(String uid) async {
    logger.i('reading additional data locally for uid: $uid');
    try {
      state = await ref.read(writingUserDataProvider.notifier).readData(uid);
      logger.i('read result: $state');
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> addNewData(UserAdditionalData data) async {
    logger.i('writing new additional data locally: $data');
    try {
      ///here we write the data then read it from the db because created_at and updated_at
      ///are init inside the data base , so writing them to the data base then reading whatever writed
      await ref.read(writingUserDataProvider.notifier).writeData(data);
      await readData(data.uid);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> updateData(UserAdditionalData data) async {
    logger.i('updating additional data locally: $data');
    try {
      await ref.read(writingUserDataProvider.notifier).updateData(data);
      await readData(data.uid);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> deleteData(String uid) async {
    logger.i('deleting additional data locally for uid: $uid');
    try {
      state = null;
      await ref.read(writingUserDataProvider.notifier).deleteData(uid);
    } catch (e) {
      logger.e(e);
    }
  }
}

final additionalDataFromLoginProvider = NotifierProvider<AddionalDataFromLogin, UserAdditionalData?>(() {
  return AddionalDataFromLogin();
});
