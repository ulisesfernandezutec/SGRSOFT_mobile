import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/data/datasource/remote/usuario/remote.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:sgrsoft/domain/services/auth_provider.dart';

GetIt getIt = GetIt.instance;

class ApiUsuarioDataSource extends RemoteUsuarioDataSource {
  List<Usuario> db;

  AuthenticationProvider authProvider = getIt();

  String url = NetConts.API_URL_USUARIO;

  ApiUsuarioDataSource({required this.db});

  @override
  Future<List<Usuario>> getList() async {
    String? authString = await authProvider.getAccessToken();
    List<Usuario> ndb = [];
    var response = await http.get(Uri.parse(url),
        headers: {'Accept': '*/*', 'Authorization': authString ?? ''});
    if (response.statusCode == 200) {
      (jsonDecode(utf8.decode(response.bodyBytes))).forEach((element) {
        ndb.add(Usuario.fromJson(element));
      });
    } else {
      throw Exception('Failed to load Data');
    }
    db = ndb;
    return db;
  }

  @override
  Future<Usuario> get(int id) async {
    if (db.isNotEmpty) {
      List<Usuario> usuarioes =
          db.where((usuario) => usuario.id == id).toList();
      if (usuarioes.isNotEmpty) {
        return usuarioes[0];
      } else {
        throw Exception("No se encontró el tipo de residuo");
      }
    } else {
      throw Exception("No existen tipos de residuos para consultar");
    }
    // try {
    //   if (kDebugMode) {
    //     print(Uri.parse(url + id.toString()));
    //   }
    //   var response = await http.get(Uri.parse(url + id.toString()),
    //       headers: {'Authorization': basicAuth, 'Accept': '*/*'});

    //   if (kDebugMode) {
    //     print(response.statusCode.toString());
    //     print(utf8.decode(response.bodyBytes));
    //     print(url);
    //   }

    //   if (response.statusCode == 200) {
    //     return Usuario.fromJson(
    //         jsonDecode(utf8.decode(response.bodyBytes)));
    //   } else {
    //     throw Exception(
    //         'Falla al traer la informacion para el tipo ${id.toString()}');
    //   }
    // } catch (e) {
    //   throw Exception("No se encontró el tipo de residuo. ${e.toString()}");
    // }
  }

  @override
  Future<bool> add(Usuario usuario) async {
    String? authString = await authProvider.getAccessToken();
    var json = usuario.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': authString ?? '',
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(usuario.toJson()));

    if (kDebugMode) {
      print(response.statusCode.toString());
      print(utf8.decode(response.bodyBytes));
      print(url);
    }

    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) == 'true') {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<bool> delete(Usuario usuario) async {
    String? authString = await authProvider.getAccessToken();
    try {
      var response = await http.delete(Uri.parse(url + usuario.id.toString()),
          headers: {'Authorization': authString ?? ''});
      if (response.statusCode == 200) {
        db.remove(usuario);
        return true;
      } else {
        throw Exception(
            'Falla al traer la informacion para el tipo ${usuario.id.toString()}');
      }
    } catch (e) {
      throw Exception("No se encontró el tipo de residuo. ${e.toString()}");
    }
  }

  @override
  Future<bool> update(Usuario usuario) async {
    String? authString = await authProvider.getAccessToken();
    var json = usuario.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': authString ?? '',
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(usuario.toJson()));

    if (kDebugMode) {
      print(response.statusCode.toString());
      print(utf8.decode(response.bodyBytes));
      print(url);
    }

    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) == 'true') {
        db.remove(usuario);
        db.add(usuario);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
