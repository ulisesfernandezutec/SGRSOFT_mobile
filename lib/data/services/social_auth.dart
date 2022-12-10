import 'package:sgrsoft/data/services/google_auth.dart';
import 'package:sgrsoft/domain/services/social_auth_provider.dart';

class SocialAuth implements SocialAuthenticationProvider {
  SocialAuthenticationProviderOption tipo;

  SocialAuth({required this.tipo});

  @override
  Future<bool> login() {
    if (SocialAuthenticationProviderOption.google == tipo) {
      return GoogleAuth().login();
      // } else {
      //   return Future.value(AuthenticationProvider());
    } else {
      return Future.value(true);
    }
  }
}
