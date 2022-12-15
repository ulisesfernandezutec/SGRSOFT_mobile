import 'dart:convert';
import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:sgrsoft/domain/services/auth_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sgrsoft/domain/services/encriptar.dart';
import 'package:sgrsoft/ui/app.dart';

class JWTAuthentication implements AuthenticationProvider {
  final _storage = const FlutterSecureStorage();
  Usuario? _usuario;

  GetIt getIt = GetIt.instance;

  @override
  Future<bool> createSession(String beared, Usuario? usuario) async {
    log("JWTAuthentication: createSession: $beared");
    String access = beared;
    String refresh = beared.split(" ")[1];
    await _storage.write(key: 'access', value: access);
    await _storage.write(key: 'refresh', value: refresh);
    var now = DateTime.now();
    await _storage.write(key: 'last_access', value: now.toString());
    await _storage.write(key: 'last_refresh', value: now.toString());
    if (usuario != null && access != '' && refresh != '') {
      await _storage.write(key: 'usuario', value: usuario.toJson().toString());
      _usuario = usuario;
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Future<String?> getAccessToken() async {
    final lastAccessStr =
        await _storage.read(key: 'last_access') ?? '1990-01-01 00:00:00';
    final lastAccess = DateTime.parse(lastAccessStr);
    final now = DateTime.now();
    if (now.difference(lastAccess).inSeconds > 300) {
      await getRefreshToken();
    }
    final value = await _storage.read(key: 'access');
    if (value != null) {
      return value;
    } else {
      navigatorKey.currentState?.pushNamed('/login');
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    final refresh = await _storage.read(key: 'refresh') ?? '';
    final access = await _storage.read(key: 'access') ?? '';
    if (refresh == '') return null;

    var headers = {
      'Authorization': access,
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*'
    };

    final response = await http.post(
        Uri.parse("${NetConts.API_JWT_REFRESH}$refresh"),
        headers: headers);
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['Token'];
      await _storage.write(key: 'access', value: token);
      await _storage.write(key: 'refresh', value: token.split(" ")[1]);
      var now = DateTime.now();
      await _storage.write(key: 'last_access', value: now.toString());
      await _storage.write(key: 'last_refresh', value: now.toString());
      return token;
    } else {
      return null;
    }
  }

  @override
  Future<Usuario?> getUsuario() async {
    return _usuario;
  }

  @override
  Future<bool> login(String email, String password) async {
    final encript = Encriptrar();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*'
    };
    final response = await http.post(Uri.parse(NetConts.API_URL_AUTH_LOGIN),
        headers: headers,
        body: jsonEncode({"email": email, "pwd": encript.encript(password)}));
    if (response.statusCode == 200) {
      log(response.body);
      final json = jsonDecode(response.body);
      final token = json['sgrToken'];
      await _storage.write(key: 'access', value: token);
      await _storage.write(key: 'refresh', value: token.split(" ")[1]);
      var now = DateTime.now();
      await _storage.write(key: 'last_access', value: now.toString());
      await _storage.write(key: 'last_refresh', value: now.toString());
      // _usuario = await usuarioRepository.get(email: json['email']);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> logout() {
    _storage.deleteAll();
    return Future.value(true);
  }
}
