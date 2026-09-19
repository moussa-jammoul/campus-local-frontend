import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:flutterfrontenduniprojectmanager/theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // insuring initialization
  await Firebase.initializeApp(); //insuring firebase initialization
  runApp(ProviderScope(
    child: Application(),  
  ));
}


class Application extends ConsumerWidget{
  const Application({super.key});


  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      theme: ThemeInfo.light,
      darkTheme: ThemeInfo.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }

}