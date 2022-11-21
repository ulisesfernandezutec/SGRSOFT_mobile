import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:http/http.dart' as http;
import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';

import 'remote.dart';

class ApiPuntoDisposicionFinalDataSource
    extends RemotePuntoDisposicionFinalDataSource {
  List<PuntoDisposicionFinal> db = [];

  String basicAuth = NetConts().getBasicAuth();
  String url = NetConts.API_URL_PUNTO_DE_RECOLECCION;

  ApiPuntoDisposicionFinalDataSource({required this.db});

  @override
  Future<List<PuntoDisposicionFinal>> getList() async {
    List<PuntoDisposicionFinal> ndb = [];
    var response = await http.get(Uri.parse(url),
        headers: {'Accept': '*/*', 'Authorization': basicAuth});
    if (response.statusCode == 200) {
      (jsonDecode(utf8.decode(response.bodyBytes))).forEach((element) {
        ndb.add(PuntoDisposicionFinal.fromJson(element));
      });
    } else {
      throw Exception('Failed to load Data');
    }
    db = ndb;
    return db;
  }

  @override
  Future<PuntoDisposicionFinal> get(int id) async {
    if (db.isNotEmpty) {
      List<PuntoDisposicionFinal> puntos =
          db.where((punto) => punto.id == id).toList();
      if (puntos.isNotEmpty) {
        return puntos[0];
      } else {
        throw Exception("No se encontró el punto de recolección");
      }
    } else {
      throw Exception("No existen puntos de recolección para consultar");
    }
  }

  @override
  Future<bool> add(PuntoDisposicionFinal puntoDisposicionFinal) async {
    var json = puntoDisposicionFinal.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(puntoDisposicionFinal.toJson()));

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
  Future<bool> delete(PuntoDisposicionFinal puntoDisposicionFinal) async {
    try {
      var response = await http.delete(
          Uri.parse(url + puntoDisposicionFinal.id.toString()),
          headers: {'Authorization': basicAuth});
      if (response.statusCode == 200) {
        db.remove(puntoDisposicionFinal);
        return true;
      } else {
        throw Exception(
            'Falla al traer la informacion para el tipo ${puntoDisposicionFinal.id.toString()}');
      }
    } catch (e) {
      throw Exception("No se encontró el tipo de residuo. ${e.toString()}");
    }
  }

  @override
  Future<bool> update(PuntoDisposicionFinal puntoDisposicionFinal) async {
    var json = puntoDisposicionFinal.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(puntoDisposicionFinal.toJson()));

    if (kDebugMode) {
      print(response.statusCode.toString());
      print(utf8.decode(response.bodyBytes));
      print(url);
    }

    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) == 'true') {
        db.remove(puntoDisposicionFinal);
        db.add(puntoDisposicionFinal);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
