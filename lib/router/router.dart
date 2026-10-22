import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/DataServices/writing_courses.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/courses/form.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/CoursesPage/presentation/page/courses_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/pages/detailed_image.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/pages/file_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/pages/image_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/pages/video_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/Media/presentation/pages/video_player_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/UserAdditionalDataRequirementPage/presentation/page/page.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/page/home_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/homepage/presentation/page/settings_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/page/login_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/page/waiting_to_verfiy_email_page.dart';
import 'package:flutterfrontenduniprojectmanager/router/refresh_listen_able.dart';
import 'package:flutterfrontenduniprojectmanager/router/router_redirect_logique.dart';
import 'package:flutterfrontenduniprojectmanager/router/routes_data.dart';
import 'package:go_router/go_router.dart';

String? getCurrentLocation({Ref? ref, WidgetRef? widgetRef}) {
  final router = ref != null
      ? ref.read(routerProvider)
      : widgetRef?.read(routerProvider);
  if (router == null) return null;

  final config = router.routerDelegate.currentConfiguration;
  final lastMatch = config.last;
  final matchList = lastMatch is ImperativeRouteMatch ? lastMatch.matches : config;
  return matchList.uri.toString();
}

final navigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref){

 final routerNotifier = RefreshListenAbleRouterNotifier(ref);

 return GoRouter(
  debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    refreshListenable:routerNotifier ,
    
    initialLocation: '/home',
    redirect: (context, state) {
      
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
        routes: [
          GoRoute(
            path: 'settings',
            builder: (context, state) {
              return SettingsPage();
            },
            ),
            GoRoute(
              path:'courses',
              builder : (context , state){
                final semester = state.extra as Semester;
                return CoursesPage(semester: semester);
              },
              routes: [
                GoRoute(
                  path: ':courseuuid/images',
                  builder: (context, state) {
                    final course = state.extra as Course;
                    return ImagePage(courseData: course,);
                  },
                  routes: [
                    GoRoute(
                      path: 'image/:uuid',
                      builder: (context, state) {
                        final data = state.extra as ImageRouteData;
                        return DetailedImage(binary: data.bytes, imageDetail: data.imageDetail);
                      },

                    )
                  ]
                ),
                GoRoute(
                  path: ':courseuuid/files',
                  builder: (context, state) {
                    final course = state.extra as Course;
                    return FilePage(courseData: course);
                  },
                ),
                GoRoute(
                  path: ':courseuuid/videos',
                  builder: (context , state){
                    final course = state.extra as Course;
                    return VideoPage(courseData: course);
                  },
                  routes: [
                    GoRoute(
                      path: 'video/:uuid',
                      builder: (context, state) {
                        final data = state.extra as VideoRouteData;
                        return VideoPlayerPage(videoPath: data.explicitPath, videoDetail: data.videoDetails);
                        
                      },
                    )
                  ]
                )

              ]
            )
        ]
      ),
      GoRoute(
        path: '/AdditionalDataSheet',
        builder: (context, state) {
          return  UserAdditionalDataRequirementPage();
        },
        )

    ],
  );

});


