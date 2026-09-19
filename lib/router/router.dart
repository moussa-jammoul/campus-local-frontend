import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/router/refresh_listen_able.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref){

 final routerNotifier = RefreshListenAbleRouterNotifier(ref);

 return GoRouter(

    refreshListenable:routerNotifier ,
    initialLocation: '/login',
    redirect: (context, state) {
      throw UnimplementedError(); //TODO check auth validity and decide redirect path
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) {
          throw UnimplementedError(); //TODO return log in page
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) {
          throw UnimplementedError(); //TODO return home page
        },
      ),
    ],
  );

});


