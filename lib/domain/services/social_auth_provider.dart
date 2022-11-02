enum SocialAuthenticationProviderOption {
  google,
  facebook,
}

abstract class SocialAuthenticationProvider {
  SocialAuthenticationProviderOption get type;
  Future<bool> login();
  Future<bool> logout();
  Future<bool> isLoggedIn();
  Future<String> getToken();
  Future<String> getRefreshToken();
  Future<String> getAccessToken();
}
