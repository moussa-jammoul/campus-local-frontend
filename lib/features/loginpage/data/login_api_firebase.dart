// ignore_for_file: unused_local_variable, body_might_complete_normally_nullable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfrontenduniprojectmanager/core/log/logger_provider.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/data/login_api_domain.dart';
import 'package:flutterfrontenduniprojectmanager/features/loginpage/data/login_form.dart';
import 'package:flutterfrontenduniprojectmanager/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class LoginApiFirebase extends Notifier<void> implements LoginApiDomain {
  
  final String mainCollectionPointUsers = 'users';
  final String usersDataAndTokensPoint = 'useritems';
  final String userDataPoint = 'userdata';
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
         await user.sendEmailVerification();
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

}

final loginApiProvider = NotifierProvider<LoginApiFirebase,void>((){
  return LoginApiFirebase();
});