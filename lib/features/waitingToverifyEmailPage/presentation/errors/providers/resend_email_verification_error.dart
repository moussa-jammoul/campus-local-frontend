// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussajammoul/campuslocal)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResendEmailVerificationError extends Notifier<String?> {

  final String rateLimitError = "You've requested too many verification emails. Please try again later.";
  final String networkError = "We couldn't resend the verification email. Please check your connection and try again.";

  @override
  String? build() {
    return null;
  }

  void customError(String error) { // for custom errors, use this function
    state = error;
  }

  void showRateLimitError() {
    state = rateLimitError;
  }

  void showNetworkError() {
    state = networkError;
  }

  void removeError() {
    state = null;
  }

}

final resendEmailVerificationErrorProvider = NotifierProvider<ResendEmailVerificationError, String?>(() {
  return ResendEmailVerificationError();
});