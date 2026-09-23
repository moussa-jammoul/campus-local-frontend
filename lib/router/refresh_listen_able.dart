import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/router/functions_after_success_clean_login.dart';
import 'package:logger/logger.dart';



//A refreshable just to notify the router something change , it may be auth states , or any other listenable
class RefreshListenAbleRouterNotifier extends ChangeNotifier {
  
  User? pre;//used to compare between old user and new user to check for changes
  late Logger logger;
  
  RefreshListenAbleRouterNotifier(Ref ref){
    logger = ref.read(loggerProvider);
    _listenToUserState(ref);
  }
  
  //this function detect whenever a user state change , if it was auth states , email verifaction changes...
  //note that email verification should have a manual button to call firebase auth reload , "so email verification actually change and we get notifie"
  void _listenToUserState(Ref ref){

    FirebaseAuth.instance.userChanges().listen((user)async{
      logger.i('userChanges fired : email : ${user?.email} , is verified : ${user?.emailVerified}' ,time: DateTime.now());
      
     
      if(user != null){
        ///this statment here detect that the user logged in
        if(pre == null){
           //here we detect that the user just opened the app and he is logged in
          
         
          if(user.emailVerified){
             ///here we know that the user account is legitamate , we can use inside this
          ///statment any function we need it to run after succesfly opened the app , or
          ///signed in and verified his email
            await handleFirstVerifiedLogin(user , logger);


          }
          pre = user;
        }
       

      }
      
      
      notifyListeners();
    });
  }
}
