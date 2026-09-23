abstract class VerifyEmailServiceDomain {
  ///firebase auth does not automaticaly send to the user side new updates when verificating email via
  ///email link , so user should manually reload his data to continue
  Future<void> reloadUser();
  Future<void> resendEmail();
}
