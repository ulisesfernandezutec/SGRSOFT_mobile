import 'auth_provider.dart';

enum SocialAuthenticationProviderOption {
  google,
  facebook,
}

abstract class SocialAuthenticationProvider {
  Future<AuthenticationProvider?> login();
}
