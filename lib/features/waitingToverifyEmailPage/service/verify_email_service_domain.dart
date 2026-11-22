// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussajammoul/campuslocal)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.

abstract class VerifyEmailServiceDomain {
  ///firebase auth does not automaticaly send to the user side new updates when verificating email via
  ///email link , so user should manually reload his data to continue
  Future<void> reloadUser();
  Future<void> resendEmail();
  Future<void> signOut();
}
