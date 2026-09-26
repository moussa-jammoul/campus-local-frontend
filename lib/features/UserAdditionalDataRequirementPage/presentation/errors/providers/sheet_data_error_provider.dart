import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailPasswordErrors extends Notifier<String?> {

  final String emptyData = "An error occurred. Please check your internet connection and make sure all required fields are filled out";

  @override
  String? build() {
    return null;
  }
  
  void customError(String error){///for custom errors , use this function
    state = error;
  }

  void showEmptyDataErrorOrNetworkError(){
    state = emptyData;
  } 

  void removeError(){
    state = null;
  }
  
}

final sheetDataErrorsProvider = NotifierProvider<EmailPasswordErrors,String?>((){
  return EmailPasswordErrors();
});