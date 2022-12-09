import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';
import 'package:http/http.dart' as http;

import 'remote.dart';

class ApiVehiculoDataSource extends RemoteVehiculoDataSource {
  List<Vehiculo> db;

  String basicAuth = NetConts().getBasicAuth();
  String url = NetConts.API_URL_VEHICULO;

  ApiVehiculoDataSource({required this.db});

  @override
  Future<List<Vehiculo>> getList() async {
    List<Vehiculo> ndb = [];
    var response = await http.get(Uri.parse(url),
        headers: {'Accept': '*/*', 'Authorization': basicAuth});
    if (response.statusCode == 200) {
      (jsonDecode(utf8.decode(response.bodyBytes))).forEach((element) {
        ndb.add(Vehiculo.fromJson(element));
      });
    } else {
      throw Exception('Failed to load Data');
    }
    db = ndb;
    return db;
  }

  @override
  Future<Vehiculo> get(int id) async {
    if (db.isNotEmpty) {
      List<Vehiculo> vehiculoes =
          db.where((vehiculo) => vehiculo.id == id).toList();
      if (vehiculoes.isNotEmpty) {
        return vehiculoes[0];
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
    //     return Vehiculo.fromJson(
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
  Future<bool> add(Vehiculo vehiculo) async {
    var json = vehiculo.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(vehiculo.toJson()));

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
  Future<bool> delete(Vehiculo vehiculo) async {
    try {
      var response = await http.delete(Uri.parse(url + vehiculo.id.toString()),
          headers: {'Authorization': basicAuth});
      if (response.statusCode == 200) {
        db.remove(vehiculo);
        return true;
      } else {
        throw Exception(
            'Falla al traer la informacion para el tipo ${vehiculo.id.toString()}');
      }
    } catch (e) {
      throw Exception("No se encontró el tipo de residuo. ${e.toString()}");
    }
  }

  @override
  Future<bool> update(Vehiculo vehiculo) async {
    var json = vehiculo.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(vehiculo.toJson()));

    if (kDebugMode) {
      print(response.statusCode.toString());
      print(utf8.decode(response.bodyBytes));
      print(url);
    }

    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) == 'true') {
        db.remove(vehiculo);
        db.add(vehiculo);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
