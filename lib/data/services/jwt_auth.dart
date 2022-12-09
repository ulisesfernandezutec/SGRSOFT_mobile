import 'package:sgrsoft/domain/services/auth_provider.dart';

class Auth implements AuthenticationProvider {
  @override
  Future<bool> createSession(String refreshToken, String accessToken) {
    // TODO: implement getRefreshToken
    throw UnimplementedError();
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
