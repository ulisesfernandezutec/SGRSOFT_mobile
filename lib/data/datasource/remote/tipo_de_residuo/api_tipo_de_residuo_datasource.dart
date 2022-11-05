import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/data/datasource/remote/tipo_de_residuo/remote.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';
import 'package:http/http.dart' as http;

class ApiTiposDeResiduosDataSource extends RemoteTiposDeResiduosDataSource {
  List<TipoDeResiduo> db;

  String basicAuth = NetConts().getBasicAuth();
  String url = NetConts.API_URL_TIPO_RESIDUO;

  ApiTiposDeResiduosDataSource({required this.db});

  @override
  Future<List<TipoDeResiduo>> getList() async {
    List<TipoDeResiduo> ndb = [];
    var response =
        await http.get(Uri.parse(url), headers: {'Authorization': basicAuth});
    if (response.statusCode == 200) {
      (jsonDecode(utf8.decode(response.bodyBytes))).forEach((element) {
        ndb.add(TipoDeResiduo.fromJson(element));
      });
    } else {
      throw Exception('Failed to load Data');
    }
    db = ndb;
    return db;
  }

  @override
  Future<TipoDeResiduo> get(int id) async {
    if (db.isNotEmpty) {
      List<TipoDeResiduo> puntos = db.where((punto) => punto.id == id).toList();
      if (puntos.isNotEmpty) {
        return puntos[0];
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
    //     return TipoDeResiduo.fromJson(
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
  Future<bool> add(TipoDeResiduo tipoResiduo) async {
    var json = tipoResiduo.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(tipoResiduo.toJson()));

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
  Future<bool> delete(TipoDeResiduo tipoResiduo) async {
    try {
      var response = await http.delete(
          Uri.parse(url + tipoResiduo.id.toString()),
          headers: {'Authorization': basicAuth});
      if (response.statusCode == 200) {
        db.remove(tipoResiduo);
        return true;
      } else {
        throw Exception(
            'Falla al traer la informacion para el tipo ${tipoResiduo.id.toString()}');
      }
    } catch (e) {
      throw Exception("No se encontró el tipo de residuo. ${e.toString()}");
    }
  }

  @override
  Future<bool> update(TipoDeResiduo tipoResiduo) async {
    var json = tipoResiduo.toJson();

    if (kDebugMode) {
      print(json.toString());
    }

    var headers = {
      'Authorization': basicAuth,
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    var response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(tipoResiduo.toJson()));

    if (kDebugMode) {
      print(response.statusCode.toString());
      print(utf8.decode(response.bodyBytes));
      print(url);
    }

    if (response.statusCode == 200) {
      if (utf8.decode(response.bodyBytes) == 'true') {
        db.remove(tipoResiduo);
        db.add(tipoResiduo);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
