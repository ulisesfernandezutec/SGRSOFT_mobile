import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:sgrsoft/domain/services/auth_provider.dart';
import 'package:sgrsoft/domain/services/social_auth_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

GetIt getIt = GetIt.instance;

class GoogleAuth implements SocialAuthenticationProvider {
  @override
  Future<bool> login() async {
    try {
      final result = await _googleSignIn.signIn();
      final GoogleSignInAuthentication ggAuth = await result!.authentication;

      if (ggAuth.accessToken == null) {
        return false;
      }
      Map<String, dynamic> map = await apiConnect(ggAuth.accessToken!);
      Usuario usuario = Usuario.fromJson(map["usuario"]);
      final auth = getIt<AuthenticationProvider>();
      await auth.createSession(map["sgrToken"], usuario);
      return true;
    } catch (error) {
      log("GoogleAuth: login: ${error.toString()}");
      return false;
    }
  }

  // Google get token
  Future<Map<String, dynamic>> apiConnect(String accessToken) async {
    var headers = {'Accept': '*/*'};

    final response = await http.get(
        Uri.parse('${NetConts.API_GOOGLE_CHECK_TOKEN}$accessToken'),
        headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      return map;
    } else {
      log("GoogleAuth: getToken: reasonPhrase: ${response.reasonPhrase.toString()}");
    }

    return {};
  }
}
