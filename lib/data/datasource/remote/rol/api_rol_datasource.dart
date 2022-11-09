import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/data/datasource/remote/rol/remote.dart';
import 'package:sgrsoft/domain/models/rol.dart';
import 'package:http/http.dart' as http;

class ApiRolDataSource extends RemoteRolDataSource {
  List<Rol> db;

  String basicAuth = NetConts().getBasicAuth();
  String url = NetConts.API_URL_USUARIO_ROL;

  ApiRolDataSource({required this.db});

  @override
  Future<List<Rol>> getList() async {
    List<Rol> ndb = [];
    var response = await http.get(Uri.parse(url),
        headers: {'Accept': '*/*', 'Authorization': basicAuth});
    if (response.statusCode == 200) {
      (jsonDecode(utf8.decode(response.bodyBytes))).forEach((element) {
        ndb.add(Rol.fromJson(element));
      });
    } else {
      throw Exception('Failed to load Data');
    }
    db = ndb;
    return db;
  }

  @override
  Future<Rol> get(int id) async {
    if (db.isNotEmpty) {
      List<Rol> roles = db.where((rol) => rol.id == id).toList();
      if (roles.isNotEmpty) {
        return roles[0];
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
    //     return Rol.fromJson(
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
  Future<bool> add(Rol rol) async {
    var json = rol.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(rol.toJson()));

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
  Future<bool> delete(Rol rol) async {
    try {
      var response = await http.delete(Uri.parse(url + rol.id.toString()),
          headers: {'Authorization': basicAuth});
      if (response.statusCode == 200) {
        db.remove(rol);
        return true;
      } else {
        throw Exception(
            'Falla al traer la informacion para el tipo ${rol.id.toString()}');
      }
    } catch (e) {
      throw Exception("No se encontró el tipo de residuo. ${e.toString()}");
    }
  }

  @override
  Future<bool> update(Rol rol) async {
    var json = rol.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(rol.toJson()));

    if (kDebugMode) {
      print(response.statusCode.toString());
      print(utf8.decode(response.bodyBytes));
      print(url);
    }

    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) == 'true') {
        db.remove(rol);
        db.add(rol);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
