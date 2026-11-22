// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussajammoul/campuslocal)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
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