import 'package:flutter_riverpod/flutter_riverpod.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
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