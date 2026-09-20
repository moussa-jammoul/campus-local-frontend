// ignore_for_file: empty_catches

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/errors/widgets/sign_in_errors_widget.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/presentation/page/create_account_page.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/service/login_service.dart';

class FormOFLogIn extends ConsumerWidget {
  final Size deviceSize;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const FormOFLogIn({
    super.key,
    required this.deviceSize,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 450,
      ),
      width: deviceSize.width * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 2,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: 
      SingleChildScrollView(
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onTapOutside:(_){
              FocusScope.of(context).unfocus();
            } ,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
             onTapOutside:(_){
              FocusScope.of(context).unfocus();
            } ,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
          const SizedBox(height: 4,),
          EmailPasswordErrorsWidget(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                unawaited(signIn(ref));
              },
              child: const Text('Sign In'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                navigateCreateAccount(ref);          
              },
              child: const Text('Create Account'),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Divider(color: Theme.of(context).colorScheme.outline)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Other methods',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Expanded(child: Divider(color: Theme.of(context).colorScheme.outline)),
            ],
          ),
          const SizedBox(height: 20),
          GoogleSignInButton()
          
        ],
      ),
      )
    );
  }

  Future<void> signIn(WidgetRef ref) async{
    await ref.read(loginServiceProvider.notifier).signIn(emailController.text,passwordController.text);
  }

  void navigateCreateAccount(WidgetRef ref){
    showCreateAccountSheet();
  }
}





/// Official "Sign in with Google" button, using Google's own pre-rendered
/// pill-shaped asset (light/dark variants).
/// do not create one by hand , or work with the official guide line if you want to change it
class GoogleSignInButton extends ConsumerWidget {
  
  final double width;

  const GoogleSignInButton({
    super.key,
    
    this.width = 240,
  });

  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final asset = isDark
        ? 'assets/icons/google_signin_dark_pill_android_web.png' /// for android , web build.
        : 'assets/icons/google_signin_light_pill_android_web.png';///ios require different image (source : google guide line)

    return Material(
      color: Colors.transparent,
      elevation: 0, // flat matching Google's reference design
      
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: (){
          ref.read(loginServiceProvider.notifier).signInWithGoogle();
        },
        child: Image.asset(
          asset,
          width: 240,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}