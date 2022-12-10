enum SocialAuthenticationProviderOption {
  google,
  facebook,
}

abstract class SocialAuthenticationProvider {
  Future<bool> login();
}
