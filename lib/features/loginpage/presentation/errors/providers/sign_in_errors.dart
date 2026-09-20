import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailPasswordErrors extends Notifier<String?> {
  final String wrongEmailPassword = "Wrong email or password";
  final String emptyEmailOrPassword = "Email and Password are both required";


  @override
  String? build() {
    return null;
  }

  void customError(String error){///for custom errors , use this function(e.g error from the db or server...)
    state = error;
  }

  void showWrongEmailOrPasswordError(){
    state = wrongEmailPassword;
  }

  void showEmptyDataError(){
    state = emptyEmailOrPassword;
  } 

  void removeError(){
    state = null;
  }
  
}

final emailPasswordErrorsProvider = NotifierProvider<EmailPasswordErrors,String?>((){
  return EmailPasswordErrors();
});