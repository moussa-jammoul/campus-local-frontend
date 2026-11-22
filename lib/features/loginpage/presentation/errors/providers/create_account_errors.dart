import 'package:flutter_riverpod/flutter_riverpod.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
class EmailPasswordErrors extends Notifier<String?> {

  final String emptyData = "All fields are required , please check any missing one";
  final String wrongRepeatedPassword = "Wrong repeate password , please write it again";



  @override
  String? build() {
    return null;
  }
  
  void customError(String error){///for custom errors , use this function
    state = error;
  }

  void showEmptyDataError(){
    state = emptyData;
  } 

  void showWrongRepeatedPassword(){
    state = wrongRepeatedPassword;
  }

  void removeError(){
    state = null;
  }
  
}

final createAccountErrorsProvider = NotifierProvider<EmailPasswordErrors,String?>((){
  return EmailPasswordErrors();
});