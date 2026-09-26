import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/additional_user_data_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/db/db_tables.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/addional_data_from_login.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/UserAdditionalDataRequirementPage/presentation/errors/providers/sheet_data_error_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/UserAdditionalDataRequirementPage/service/addtional_data_service_domain.dart';
import 'package:flutterfrontenduniprojectmanager/router/functions_after_success_clean_login.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';

class AdditionalDataService extends Notifier<void> implements AddtionalDataServiceDomain {
  late Logger logger;
  @override
  void build() {
    logger = ref.read(loggerProvider);
    
  }

  @override
  Future<void> submit(UserAdditionalData data) async{
    logger.i("submiting..");
    await ref.read(additionalDataFromLoginProvider.notifier).addNewData(data);
    try{
    final dataLocal = ref.read(additionalDataFromLoginProvider);//needed , so create at and update at are initialized inside the db
    await ref.read(cloudAdditionalUserDataDB.notifier).createUserData(dataLocal!);
    ref.read(sheetDataErrorsProvider.notifier).removeError();
    //this variable defined in /router/functions_after_succes... 
    userDataExistInTheCloud = true;
    navigatorKey.currentContext?.go('/home');
    }catch(e){
      logger.e(e);
      ref.read(sheetDataErrorsProvider.notifier).showEmptyDataErrorOrNetworkError();
    }
  }

}

final additionalDataServiceProvider = NotifierProvider<AdditionalDataService, void>((){
  return AdditionalDataService();
});