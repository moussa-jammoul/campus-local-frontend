import 'package:firebase_auth/firebase_auth.dart';
// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
abstract class LoginApiDomain {
  Future<UserCredential?> signIn(String email , String password);
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> createAccount(String email, String password);
  Future<void> logOut();
}