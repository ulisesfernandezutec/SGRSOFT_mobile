import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:http/http.dart' as http;
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/domain/services/auth_provider.dart';

import 'remote.dart';

GetIt getIt = GetIt.instance;

class ApiRutaDataSource extends RemoteRutaDataSource {
  List<Ruta> db = [];

  AuthenticationProvider authProvider = getIt();
  String url = NetConts.API_URL_RUTA;

  ApiRutaDataSource({required this.db});

  @override
  Future<List<Ruta>> getList() async {
    String? authString = await authProvider.getAccessToken();
    List<Ruta> ndb = [];
    var response = await http.get(Uri.parse(url), headers: {
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*',
      'Authorization': authString ?? ''
    });
    if (response.statusCode == 200) {
      (jsonDecode(utf8.decode(response.bodyBytes))).forEach((element) {
        ndb.add(Ruta.fromJson(element));
      });
    } else {
      throw Exception('Failed to load Data');
    }
    db = ndb;
    return db;
  }

  @override
  Future<Ruta> get(int id) async {
    if (db.isNotEmpty) {
      List<Ruta> puntos = db.where((punto) => punto.id == id).toList();
      if (puntos.isNotEmpty) {
        return puntos[0];
      } else {
        throw Exception("No se encontró la ruta");
      }
    } else {
      throw Exception("No existen rutas para consultar");
    }
    // try {
    //   var response = await http.get(Uri.parse(url + id.toString()),
    //       headers: {'Authorization': basicAuth});
    //   if (response.statusCode == 200) {
    //     return Ruta.fromJson(
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
  Future<bool> add(Ruta ruta) async {
    String? authString = await authProvider.getAccessToken();
    var json = ruta.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': authString ?? '',
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(ruta.toJson()));

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
  Future<bool> delete(Ruta ruta) async {
    String? authString = await authProvider.getAccessToken();
    try {
      var response = await http.delete(Uri.parse(url + ruta.id.toString()),
          headers: {'Authorization': authString ?? ''});
      if (response.statusCode == 200) {
        db.remove(ruta);
        return true;
      } else {
        throw Exception(
            'Falla al traer la informacion para el tipo ${ruta.id.toString()}');
      }
    } catch (e) {
      throw Exception("No se encontró el tipo de residuo. ${e.toString()}");
    }
  }

  @override
  Future<bool> update(Ruta ruta) async {
    String? authString = await authProvider.getAccessToken();
    var json = ruta.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': authString ?? '',
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(ruta.toJson()));

    if (kDebugMode) {
      print(response.statusCode.toString());
      print(utf8.decode(response.bodyBytes));
      print(url);
    }

    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) == 'true') {
        db.remove(ruta);
        db.add(ruta);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
