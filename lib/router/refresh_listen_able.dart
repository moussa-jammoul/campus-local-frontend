import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/router/functions_after_success_clean_login.dart';
import 'package:logger/logger.dart';



//A refreshable just to notify the router something change , it may be auth states , or any other listenable
class RefreshListenAbleRouterNotifier extends ChangeNotifier {
  
 
  late Logger logger;
  
  RefreshListenAbleRouterNotifier(Ref ref){
    logger = ref.read(loggerProvider);
    _listenToUserState(ref);
  }
  
  //this function detect whenever a user state change , if it was auth states , email verifaction changes...
  //note that email verification should have a manual button to call firebase auth reload , "so email verification actually change and we get notifie"
  User? pre;//used to compare between old user and new user to check for changes
  bool hasRunFirstVerifiedLogin = false;

void _listenToUserState(Ref ref) {
  FirebaseAuth.instance.userChanges().listen((user) async {
    logger.i('userChanges fired : email : ${user?.email} , is verified : ${user?.emailVerified}', time: DateTime.now());

    if (user != null) {
      if (pre == null) {
        logger.i("pre user is null");
        pre = user;
      }

      if (user.emailVerified && !hasRunFirstVerifiedLogin) {
        logger.i("email is verified, running first verified login logic");
        hasRunFirstVerifiedLogin = true;
        await handleFirstVerifiedLogin(user, logger, ref);
      }
    } else {
      // user sign out here , we should refresh both so when he sign in again he don't miss those fields from running in the next sign in
      pre = null;
      hasRunFirstVerifiedLogin = false;
    }

    notifyListeners();
  });
}
}
