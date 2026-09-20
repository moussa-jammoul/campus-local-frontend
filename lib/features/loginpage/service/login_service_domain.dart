abstract class LoginServiceDomain {
  Future<void> signIn(String email , String password);
  Future<void> createAccount(String email , String password, String passwordRepeated , String fullName , String dateOfBirth ,String role ,String major);
  Future<void> signInWithGoogle();
}