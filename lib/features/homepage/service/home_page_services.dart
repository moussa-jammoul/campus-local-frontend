import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/device_token_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/semester_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_device_token.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/all_devices_token_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/semester_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/service/home_page_services_domain.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/data/login_api_firebase.dart';
import 'package:logger/logger.dart';

class HomePageServices extends Notifier<void> implements HomePageServicesDomain  {
  late Logger logger;
  @override
  void build() {
    logger = ref.read(loggerProvider);
  } 

  //TODO : build delete semester , however ,deleting a semester or a course require more work to delete all nested course and media ,so i should finish first course and media then jump to delete semester

  @override
  Future<void> createNewSemester(Semester rawdata) async{
    try{
    final data = await ref.read(semesterProvider.notifier).addData(rawdata);

    ///for the local-first architecture , we don't need to wait firestore function here
    ///because it will keep trying until connection resolve
    unawaited(
    ref.read(semesterCloudProvider.notifier).addNewSemester(data)
    );
    }catch(e){
      logger.e(e);
    }
  }

  

  

  @override
  Future<void> logOut() async {
    logger.i("logging out from the home page");
    await ref.read(loginApiProvider.notifier).logOut();
  }

  @override
Future<void> refreshLinkedDevices() async {
  logger.i("refresh linked devices...");
  final devices = await ref.read(cloudDeviceTokenDataDB.notifier).getAllUserData(FirebaseAuth.instance.currentUser!.uid);

  if (devices != null) {
    ref.read(allDevicesTokenProvider.notifier).addAllDevices(devices);
  }
  
}

  @override
  Future<void> updateSemester(Semester rawdata) async {
    try{
      logger.i(rawdata.toString());
    final data = await ref.read(semesterProvider.notifier).updateData(rawdata);
    logger.i(data.toString());

    ///for the local-first architecture , we don't need to wait firestore function here
    ///because it will keep trying until connection resolve
    unawaited(
    ref.read(semesterCloudProvider.notifier).updateSemester(data)
    );
    }catch(e){
      logger.e(e);
    }
    

    
  }

}

final homePageServiceProvider = NotifierProvider<HomePageServices,void>((){
  return HomePageServices();
});