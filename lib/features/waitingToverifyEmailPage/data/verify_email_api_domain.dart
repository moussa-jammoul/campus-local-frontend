import 'package:firebase_auth/firebase_auth.dart';

abstract class VerifyEmailApiDomain {
  ///firebase auth does not automaticaly send to the user side new updates when verificating email via
  ///email link , so user should manually reload his data to continue
  Future<User?> reloadUser();
  Future<void> resendEmail();
}