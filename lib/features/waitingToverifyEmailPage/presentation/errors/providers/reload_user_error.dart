import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReloadUserError extends Notifier<String?> {

  final String emailNotVerify = "Your email hasn't been verified yet , please verify it.";
  final String userError = "We couldn't verify your email status. Please check your connection and try again, or log in again if the issue persists.";

  @override
  String? build() {
    return null;
  }
  
  void customError(String error){///for custom errors , use this function
    state = error;
  }

  void showEmailNotVerified(){
    state = emailNotVerify;
  } 

  void showUserError(){
    state = userError;
  }

  void removeError(){
    state = null;
  }
  
}

final reloadUserErrorProvider = NotifierProvider<ReloadUserError,String?>((){
  return ReloadUserError();
});