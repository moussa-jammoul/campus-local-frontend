import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/page/home_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/page/login_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/page/waiting_to_verfiy_email_page.dart';
import 'package:flutterfrontenduniprojectmanager/router/refresh_listen_able.dart';
import 'package:flutterfrontenduniprojectmanager/router/router_redirect_logique.dart';
import 'package:go_router/go_router.dart';





final routerProvider = Provider<GoRouter>((ref){

 final routerNotifier = RefreshListenAbleRouterNotifier(ref);

 return GoRouter(

    refreshListenable:routerNotifier ,
    initialLocation: '/home',
    redirect: (context, state) {
      //checking auth states , redirectResult used to be the result of chaining of redirects 
      String? redirectResult = ref.read(routerRedirectLogiqueProvider.notifier).authRedirect(state);
      if (redirectResult != null){
        return redirectResult;
      }

      //checking if email verified
      redirectResult = ref.read(routerRedirectLogiqueProvider.notifier).emailVerificationRedirect(state);
      if(redirectResult != null){
        return redirectResult;
      }
      
      return null;
},
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: '/waitingToVerify',
         builder: (context, state) {
          return WaitingToVerfiyEmailPage();
        },

      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          return HomePage();
        },
      ),
    ],
  );

});


