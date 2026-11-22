// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussajammoul/campuslocal)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
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