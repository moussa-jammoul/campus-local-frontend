import 'package:flutter_riverpod/flutter_riverpod.dart';

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