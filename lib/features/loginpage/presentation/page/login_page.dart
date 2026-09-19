import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/widgets/graduate_lottie.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/widgets/loginText.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(child:SingleChildScrollView(
          child: Column(
                 children: [
                  GraduateLottie(),
                  Logintext(),
                  //TODO : make a form (container squished to up) with columns sign in , create account , sign in with google
                  //with information and author of the project
    
                 ],
          ),
)
      )

    );
  }
}