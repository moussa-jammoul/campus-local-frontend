import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/addional_data_from_login.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/data/login_api_firebase.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/errors/providers/create_account_errors.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/errors/providers/sign_in_errors.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/service/login_service_domain.dart';
import 'package:logger/logger.dart';


class LoginService extends Notifier<void> implements LoginServiceDomain {
  late Logger logger;
  @override
  void build() {
    logger = ref.read(loggerProvider);
  }
  
  @override
  Future<void> createAccount(String email, String password, String passwordRepeated, String fullName, String dateOfBirth, String role, String major) async{
    
    logger.i("creating account !");
    final valid = _validateCreateAccount(email, password, passwordRepeated, fullName, dateOfBirth, major);
    if(!valid){
      //we handled pushing error in the validator itself so we don't loose error type
      throw Error(); //we need it to prevent the bottom sheet to be closed
    }
    ref.read(createAccountErrorsProvider.notifier).removeError();

    final cred = await ref.read(loginApiProvider.notifier).createAccount(email, password);

    if(cred == null){
      ref.read(createAccountErrorsProvider.notifier).customError('An error occurred while creating your account. The email may already be in use, or you may have lost connection while creating the account. Please try again later.');
      throw Error();// again we need to to prevent the bottom sheet to be closed
    }
    if(FirebaseAuth.instance.currentUser != null){
    ref.read(additionalDataFromLoginProvider.notifier).addNewData(UserAdditionalData(uid: FirebaseAuth.instance.currentUser!.uid, email: email, fullname: fullName, dateOfBirth: dateOfBirth, role: role, major: major));
    }
    
    
  }

  @override
  Future<void> signIn(String email, String password) async {
    logger.i("signing in !");
    final valid = _validateEmailPass(email, password);
    if(!valid){
      ref.read(emailPasswordErrorsProvider.notifier).showEmptyDataError();
      logger.e("bad inputs");
      return;
    }
    ref.read(emailPasswordErrorsProvider.notifier).removeError();
    final cred = await ref.read(loginApiProvider.notifier).signIn(email, password);
    if(cred == null){
      ref.read(createAccountErrorsProvider.notifier).customError('An error occurred while signing in. The email may not exist as a user, or you may have lost connection while signing in. Please try again later.');
      return ;
    }

    

  }

  @override
  Future<void> signInWithGoogle() async {
    logger.i("signing in with google !");
    final cred = await ref.read(loginApiProvider.notifier).signInWithGoogle();
    if(cred == null){
      ref.read(emailPasswordErrorsProvider.notifier).customError('failed to sign in with google');
      logger.e("failed to signing in with google");
      return;
    } 
    ///no need her to do anything if new account , everything handled automatically to show the page for 
    ///additional data to insert them by user
    
  }

  bool _validateCreateAccount(String email, String password, String passwordRepeated, String fullName, String dateOfBirth, String major){
    if(email == '' || password == '' || passwordRepeated == '' || fullName == '' || dateOfBirth == '0-00-0000' || major == ''){
      ref.read(createAccountErrorsProvider.notifier).showEmptyDataError();
      return false;
          
    }
    else if(password != passwordRepeated){
      ref.read(createAccountErrorsProvider.notifier).showWrongRepeatedPassword();
      return false;
    }
  
    return true;

  }
  bool _validateEmailPass(String email, String password){
    if(email == '' || password == ''){
      return false;
    }
    return true;

  }
}

final loginServiceProvider = NotifierProvider<LoginService,void>((){
  return LoginService();
});