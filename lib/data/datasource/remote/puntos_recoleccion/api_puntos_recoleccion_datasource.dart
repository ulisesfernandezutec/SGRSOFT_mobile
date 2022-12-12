import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:http/http.dart' as http;
import 'package:sgrsoft/domain/models/punto_recoleccion_estado.dart';
import 'package:sgrsoft/domain/models/utils/search_puntos_recoleccion.dart';

class ApiPuntosRecoleccionDataSource extends RemotePuntosRecoleccionDataSource {
  List<PuntoRecoleccion> db = [];

  String basicAuth = NetConts().getBasicAuth();
  String url = NetConts.API_URL_PUNTO_DE_RECOLECCION;

  ApiPuntosRecoleccionDataSource({required this.db});

  @override
  Future<List<PuntoRecoleccion>> getList(
      SearchPuntosRecoleccionObject? search) async {
    List<PuntoRecoleccion> ndb = [];
    var response = await http.get(Uri.parse(url),
        headers: {'Accept': '*/*', 'Authorization': basicAuth});
    if (response.statusCode == 200) {
      (jsonDecode(utf8.decode(response.bodyBytes))).forEach((element) {
        ndb.add(PuntoRecoleccion.fromJson(element));
      });
    } else {
      throw Exception('Failed to load Data');
    }
    db = ndb;
    return db;
  }

  @override
  Future<PuntoRecoleccion> get(int id) async {
    if (db.isNotEmpty) {
      List<PuntoRecoleccion> puntos =
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
  Future<bool> add(PuntoRecoleccion puntoRecoleccion) async {
    puntoRecoleccion.estados = <PuntoRecoleccionEstado>[
      (PuntoRecoleccionEstado(
          0, DateTime.now(), 1, 'Nuevo', 'Ingresado por el usuario'))
    ];
    var json = puntoRecoleccion.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(puntoRecoleccion.toJson()));

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
  Future<bool> delete(PuntoRecoleccion puntoRecoleccion) async {
    try {
      var response = await http.delete(
          Uri.parse(url + puntoRecoleccion.id.toString()),
          headers: {'Authorization': basicAuth});
      if (response.statusCode == 200) {
        db.remove(puntoRecoleccion);
        return true;
      } else {
        throw Exception(
            'Falla al traer la informacion para el tipo ${puntoRecoleccion.id.toString()}');
      }
    } catch (e) {
      throw Exception("No se encontró el tipo de residuo. ${e.toString()}");
    }
  }

  @override
  Future<bool> update(PuntoRecoleccion puntoRecoleccion) async {
    var json = puntoRecoleccion.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(puntoRecoleccion.toJson()));

    if (kDebugMode) {
      print(response.statusCode.toString());
      print(utf8.decode(response.bodyBytes));
      print(url);
    }

    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) == 'true') {
        db.remove(puntoRecoleccion);
        db.add(puntoRecoleccion);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
