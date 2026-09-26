import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/form.dart';

abstract class AddtionalDataServiceDomain {
  Future<void> submit(UserAdditionalData data);
}