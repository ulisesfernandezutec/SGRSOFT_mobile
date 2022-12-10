import 'dart:convert';

import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/domain/models/azure/optimized_waypoint.dart';
import 'package:sgrsoft/domain/models/ruta_punto.dart';
import 'package:http/http.dart' as http;

class ApiAzureBestOrder {
  String url = NetConts.AZURE_BEST_ORDER;
  ApiAzureBestOrder();

  Future<List<RutaPunto>> optimize(List<RutaPunto> puntos) async {
    String urlParams = "";
    if (puntos.length == 2) return [];
    if (puntos.length <= 4) return puntos.sublist(1, puntos.length - 1);
    for (RutaPunto p in puntos) {
      urlParams += "${p.punto.latitud},${p.punto.longitud}:";
    }
    urlParams = urlParams.substring(0, urlParams.length - 1);

    List<RutaPunto> optimizado = puntos.sublist(1, puntos.length - 1);
    List<RutaPunto> optimizado2 = puntos.sublist(1, puntos.length - 1);

    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*'
    };
    var response = await http.get(Uri.parse(url + urlParams), headers: headers);
    if (response.statusCode == 200) {
      List<OptimizedWaypoint> optimizedWaypoints = [];
      (jsonDecode(response.body)["optimizedWaypoints"]).forEach((e) {
        optimizedWaypoints.add(OptimizedWaypoint.fromJson(e));
      });

      for (OptimizedWaypoint m in optimizedWaypoints) {
        optimizado[m.optimizedIndex] = optimizado2[m.providedIndex];
      }
      // optimizado.insert(0, start);
      // optimizado.add(end);
      return optimizado;
    } else {
      return puntos;
    }
  }
}
