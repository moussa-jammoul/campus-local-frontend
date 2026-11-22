// Required Notice: Copyright 2026 Moussa Jammoul (https://github.com/moussa-jammoul/campus-local-frontend)
// Licensed under the PolyForm Noncommercial License 1.0.0.
// See LICENSE.md in the project root or https://polyformproject.org/licenses/noncommercial/1.0.0 for full terms.
abstract class LoginServiceDomain {
  Future<void> signIn(String email , String password);
  Future<void> createAccount(String email , String password, String passwordRepeated , String fullName , String dateOfBirth ,String role ,String major);
  Future<void> signInWithGoogle();
}