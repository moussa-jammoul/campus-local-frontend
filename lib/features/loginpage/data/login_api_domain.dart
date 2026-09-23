import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginApiDomain {
  Future<UserCredential?> signIn(String email , String password);
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> createAccount(String email, String password);
}