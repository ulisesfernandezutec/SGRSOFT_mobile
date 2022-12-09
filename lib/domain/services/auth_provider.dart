abstract class AuthenticationProvider {
  Future<bool> login(String username, String password);
  Future<bool> logout();
  Future<bool> createSession(String refreshToken, String accessToken);
  Future<String> getRefreshToken();
  Future<String> getAccessToken();

  // Future<bool> register(String username, String password);
  // Future<bool> changePassword(String oldPassword, String newPassword);
  // Future<bool> resetPassword(String email);
  // Future<bool> changeEmail(String password, String newEmail);
  // Future<bool> verifyEmail(String email, String code);
  // Future<bool> resendVerificationEmail(String email);

  // Future<bool> isLoggedIn();

}
