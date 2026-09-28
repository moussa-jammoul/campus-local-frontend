import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignOutError extends Notifier<String?> {

  final String error = "failed to sign out , try again.";
 

  @override
  String? build() {
    return null;
  }
  
  void customError(String error){///for custom errors , use this function
    state = error;
  }

  void showError(){
    state = error;
  }

  void removeError(){
    state = null;
  }
  
}

final signOutErrorProvider = NotifierProvider<SignOutError,String?>((){
  return SignOutError();
});