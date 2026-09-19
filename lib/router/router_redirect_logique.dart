import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';

class RouterRedirectLogique extends Notifier<void> {

  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider);
  }
  

  //this function is used to check whenever a user auth states [e.g tokens , sign in , sign out...] change, 
  //checking if he should be in /home Or /Login page , it is just a Gate to prevent misspages , instead of relying on
  //it to change pages whenever needed
  String? authRedirect(GoRouterState state){
    logger.i('auth redirect fired : current state : ${state.fullPath} ');
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final isGoingToLogin = state.matchedLocation == '/login';

    if (!isLoggedIn && !isGoingToLogin) {
        logger.i('user not logged in and not on /login -> redirecting to /login');
        return '/login';
    }
    if (isLoggedIn && isGoingToLogin) {
        logger.i('user logged in but on /login -> redirecting to /home');
        return '/home';
    }

      logger.d('authRedirect: no redirect needed');
      return null;
  }
  

  //verify whenever the user email is verified or yet
  String? emailVerificationRedirect(GoRouterState state){
    logger.i('email verification redirect fired : current state : ${state.fullPath} ');
    final emailVerified = FirebaseAuth.instance.currentUser?.emailVerified;
    final isOnVerifyPage = state.matchedLocation == '/waitingToVerify';
    
    //emial verified here can be also used as a sign if user is logged in or not ,because it's nullness come from currentuser
    if(emailVerified != null){
      if(!emailVerified && !isOnVerifyPage){
        logger.i('email not verified and not on /waitingToVerify -> redirecting to /waitingToVerify');
        return '/waitingToVerify';
      }
      if(emailVerified && isOnVerifyPage){
        logger.i('email verified but on /waitingToVerify -> redirecting to /home');
        return '/home';
      }
      logger.d('emailVerificationRedirect: no redirect needed');
      return null;
    }
    else{
      logger.w('emailVerificationRedirect called with no current user -> redirecting to /login');
      return '/login';
    }

  }

}

final routerRedirectLogiqueProvider = NotifierProvider<RouterRedirectLogique,void>((){
  return RouterRedirectLogique();
});