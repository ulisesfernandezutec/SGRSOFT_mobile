import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/domain/services/auth_provider.dart';
import 'package:sgrsoft/domain/services/social_auth_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

GetIt getIt = GetIt.instance;

class GoogleAuth implements SocialAuthenticationProvider {
  @override
  Future<AuthenticationProvider?> login() async {
    try {
      final result = await _googleSignIn.signIn();
      final GoogleSignInAuthentication ggAuth = await result!.authentication;
      // if (kDebugMode) {
      //   print(ggAuth.idToken);
      //   print(ggAuth.accessToken);
      //   print(_googleSignIn.currentUser);
      // }
      final auth = getIt<AuthenticationProvider>();
      await auth.createSession(ggAuth.idToken!, ggAuth.accessToken!);
      return null;
    } catch (error) {
      log(error.toString());
      return null;
    }
  }
}
