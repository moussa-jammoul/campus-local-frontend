// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/courses_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/cloud/domain/semester_cloud_domain.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/all_devices_token_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/deviceTokensManagment/device_token_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/semester/semester_provider.dart';
import 'package:flutterfrontenduniprojectmanager/core/database/local/providersAndForms/userAdditionalData/additionalDataFromLogin/addional_data_from_login.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/data/login_api_domain.dart';

import 'package:flutterfrontenduniprojectmanager/main.dart';
import 'package:flutterfrontenduniprojectmanager/router/router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class LoginApiFirebase extends Notifier<void> implements LoginApiDomain {
  
  late Logger logger;

  @override
  void build() {
    logger = ref.read(loggerProvider); 
  }

  @override
  Future<UserCredential?> createAccount(String email, String password) async {

    logger.i("creating account for a user via firebase auth");
    try{
      final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = cred.user;

      if (user != null && !user.emailVerified) {
        try{
         await user.sendEmailVerification();
        } catch(e){
          logger.e(e);
        }
      }
      return cred;

    } catch(e){
      logger.e(e);
      return null;
    }
    
    
  }

  @override
  Future<UserCredential?> signIn(String email, String password) async {
    logger.i("signing in for a user via firebase auth");
    try{
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return cred;
    } catch(e){
      logger.e(e);
      return null;
    }


   
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try{

      logger.i("signInWithGoogle data layer called, instance=${identityHashCode(this)}, ");
       
    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

    
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null) {
      logger.e("no id token found");
      return null;
    }

   
    final credential = GoogleAuthProvider.credential(idToken: idToken);

    
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;

    } catch(e){
      logger.e(e);
      return null;
    }
    
  }

  @override
  Future<void> logOut() async {
    try{
      

    await FirebaseAuth.instance.signOut();

    
    final ctx = navigatorKey.currentContext;
    if(ctx != null && ctx.mounted) Application.resetSessionScope(ctx);

    }catch(e){
      logger.e(e);
      rethrow;
    }
  }

}

final loginApiProvider = NotifierProvider<LoginApiFirebase,void>((){
  return LoginApiFirebase();
});