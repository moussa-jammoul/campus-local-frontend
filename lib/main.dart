// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:flutterfrontenduniprojectmanager/theme/theme_data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

///TODO missing in the app : 
///push the commit to git hub
///device-to-device sending media 
///dead lines (add , delete) with its ui , page , small reference in the home page
///demo/tutorial inside the app itself  , user can choose when he download the app with what mode he enter ( tutorial or already know the app)

final GoogleSignIn googleSignIn = GoogleSignIn.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // insuring initialization
  await googleSignIn.initialize(
    serverClientId: '222672835640-t0t7s3m3tq5ku9jqfv1m1ne72qeohi1o.apps.googleusercontent.com',
  );
  await Firebase.initializeApp(); //insuring firebase initialization
  

  ///fetching theme mode set by user or null so we use the system of his device
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool(isDarkKey); // null if never set
  final initialThemeMode =
      isDark == null ? ThemeMode.system : (isDark ? ThemeMode.dark : ThemeMode.light);
  runApp(ProviderScope(
     overrides: [
      themeModeProvider.overrideWith(
        () => ThemeModeNotifier(initialThemeMode),
      ),
    ],
    child: Application(),  
  ));
}


class Application extends ConsumerWidget{
  const Application({super.key});


  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final thememode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      theme: ThemeInfo.light,
      darkTheme: ThemeInfo.dark,
      themeMode:thememode,
      routerConfig: router,
    );
  }

}