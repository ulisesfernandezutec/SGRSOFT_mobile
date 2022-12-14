import '../models/usuario.dart';

abstract class AuthenticationProvider {
  Future<bool> login(String username, String password);
  Future<bool> logout();
  Future<bool> createSession(String token, Usuario? usuario);
  Future<Usuario?> getUsuario();
  Future<String?> getRefreshToken();
  Future<String?> getAccessToken();

  // Future<bool> register(String username, String password);
  // Future<bool> changePassword(String oldPassword, String newPassword);
  // Future<bool> resetPassword(String email);
  // Future<bool> changeEmail(String password, String newEmail);
  // Future<bool> verifyEmail(String email, String code);
  // Future<bool> resendVerificationEmail(String email);

  // Future<bool> isLoggedIn();

}
