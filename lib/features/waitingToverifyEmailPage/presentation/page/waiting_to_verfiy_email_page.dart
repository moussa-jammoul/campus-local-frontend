import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/data/login_api_firebase.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/errors/widgets/sign_out_error_widget.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/widgets/box_of_verification.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/presentation/widgets/email_animation.dart';
import 'package:flutterfrontenduniprojectmanager/features/waitingToverifyEmailPage/service/verify_email_service.dart';

class WaitingToVerfiyEmailPage extends ConsumerStatefulWidget {
  const WaitingToVerfiyEmailPage({super.key});

  @override
  ConsumerState<WaitingToVerfiyEmailPage> createState() => _WaitingToVerfiyEmailPageState();
}

class _WaitingToVerfiyEmailPageState extends ConsumerState<WaitingToVerfiyEmailPage> {

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
      appBar: AppBar(
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: (){
              unawaited(ref.read(verifyEmailServiceProvider.notifier).signOut());
            }, 
            icon: Icon(
              Icons.logout,
            ),
            ),
            SignOutErrorWidget()
          ],
        ),

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              EmailAnimation(),
              SizedBox(
                width: 200,
                height: 100,
                child: Text(
                  'Verify your email to continue with Campus Local',
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight(500)
                  ),
                ),
              ),
              BoxOfVerification()
            ],
          ),
        ),
      ),
      
    );
  }
}