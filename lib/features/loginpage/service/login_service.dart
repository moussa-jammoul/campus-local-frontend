import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
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
  Future<void> createAccount(String email, String password, String passwordRepeated, String fullName, String? dateOfBirth, String role, String major) async{
    
    logger.i("creating account !");
    final valid = _validateCreateAccount(email, password, passwordRepeated, fullName, dateOfBirth, major);
    if(!valid){
      //we handled pushing error in the validator itself so we don't loose error type
      throw Error(); //we need it to prevent the bottom sheet to be closed
    }
    ref.read(createAccountErrorsProvider.notifier).removeError();

    // TODO: implement createAccount
    
    
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
    //TODO: implement signIn
  }

  @override
  Future<void> signInWithGoogle() async {
    logger.i("signing in with google !");
     //TODO: implement sigin with google
    
  }

  bool _validateCreateAccount(String email, String password, String passwordRepeated, String fullName, String? dateOfBirth, String major){
    if(email == '' || password == '' || passwordRepeated == '' || fullName == '' || dateOfBirth == null || major == ''){
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