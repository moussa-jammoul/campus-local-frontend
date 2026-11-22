

// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.

// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:flutterfrontenduniprojectmanager/theme/theme_data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';



final GoogleSignIn googleSignIn = GoogleSignIn.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // insuring initialization
  await googleSignIn.initialize(
    serverClientId: '222672835640-t0t7s3m3tq5ku9jqfv1m1ne72qeohi1o.apps.googleusercontent.com',
  );
  await Firebase.initializeApp(); //insuring firebase initialization
  

  ///fetching theme mode set by user 
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool(isDarkKey); // null if never set
  final initialThemeMode =
      isDark == null ? ThemeMode.system : (isDark ? ThemeMode.dark : ThemeMode.light);
  runApp( Application(themeModeApp: initialThemeMode,), );
}


class Application extends StatefulWidget {
  final ThemeMode themeModeApp;
  const Application({super.key, required this.themeModeApp});

  static void resetSessionScope(BuildContext context) {
    //safe to be called at any level under the application state , because the "Application state" wired directly above the provider scope
    context.findAncestorStateOfType<_ApplicationState>()?._reset();
  }

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  //to invalidate all providers scope , e.g when logging out , we should invalidate all providers (which also stop the streams) , but invalidating them manually is heavy work and require on each new feature to add it to a list of invalidations, so instead , we change the key of the provider scope , so everything build from scratch again lazilly
  int _epoch = 0;

  void _reset() {
    setState(() {
      _epoch++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      key: ValueKey(_epoch), //each time we reset the key ,all providers lived inside the provider container will be deleted , new ones will be rebuild lazelly after we call them one by one
      overrides: [
        themeModeProvider.overrideWith(
          () => ThemeModeNotifier(widget.themeModeApp),
        ),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends ConsumerWidget {
  const _AppView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      theme: ThemeInfo.light,
      darkTheme: ThemeInfo.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}