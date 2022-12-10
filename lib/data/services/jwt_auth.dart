import 'dart:developer';

import 'package:sgrsoft/domain/services/auth_provider.dart';

class Auth implements AuthenticationProvider {
  @override
  Future<bool> createSession(String token) {
    log("Auth $token");
    return Future.value(true);
  }

  @override
  Future<String> getAccessToken() {
    // TODO: implement getAccessToken
    throw UnimplementedError();
  }

  @override
  Future<String> getRefreshToken() {
    // TODO: implement getRefreshToken
    throw UnimplementedError();
  }

  @override
  Future<bool> login(String username, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
