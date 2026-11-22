import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/widgets/footer.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/widgets/form.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/widgets/graduate_lottie.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/widgets/loginText.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late Size sizeDevice;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sizeDevice = MediaQuery.of(context).size;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(child:
      SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                  GraduateLottie(),
                  Logintext(),
                  const SizedBox(height: 20,),
                  FormOFLogIn(deviceSize: sizeDevice,emailController: emailController,passwordController: passwordController,),
                  const SizedBox(height: 6,),
                  ProjectInfoFooter(),       
                 ],
          ),
)
      )

    );
  }
}