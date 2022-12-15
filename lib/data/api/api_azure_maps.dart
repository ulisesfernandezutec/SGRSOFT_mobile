import 'dart:convert';
import 'dart:developer';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/domain/models/azure/azure_map_response.dart';
import 'package:sgrsoft/domain/models/azure/azure_optimized_waypoint.dart';
import 'package:sgrsoft/domain/models/azure/azure_points.dart';
import 'package:sgrsoft/domain/models/azure/azure_routes.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/domain/models/ruta_punto.dart';
import 'package:http/http.dart' as http;

class ApiAzureMaps {
  List<LatLng> _polylines = [];
  get polylines => _polylines;

  ApiAzureMaps();

  Future<Ruta> procesRoute({ruta, optimizar = false}) async {
    if (ruta.salida == null || ruta.disposicionFinal == null) {
      return Future.value(ruta);
    }
    List<RutaPunto> optimizado = [...ruta.puntos];

    for (RutaPunto rp in optimizado) {
      log("original: ${rp.punto.direccion}");
    }

    String url = NetConts.AZURE_BEST_ORDER;
    String urlParams = ruta.salida != null
        ? "${ruta.salida.latitud},${ruta.salida.longitud}:"
        : "";

    for (RutaPunto p in ruta.puntos) {
      urlParams += "${p.punto.latitud},${p.punto.longitud}:";
    }

    if (ruta.disposicionFinal != null) {
      urlParams +=
          "${ruta.disposicionFinal.latitud},${ruta.disposicionFinal.longitud}";
    } else {
      urlParams = urlParams.substring(0, urlParams.length - 1);
    }

    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Access-Control-Allow-Origin': '*'
    };

    if (optimizar && ruta.puntos.length > 0) {
      url += "&computeBestOrder=true&RouteRepresentationForBestOrder=polyline";
    }

    // Obtengo los datos de AzureMapsReponse
    try {
      url = "$url&query=$urlParams";
      var response = await http.get(Uri.parse(url), headers: headers);

      // Si la respuesta es correcta (200) comienzo con el proceso
      if (response.statusCode == 200) {
        // Obtengo el objeto AzureMapResponse
        AzureMapResponse azureMapResponse =
            AzureMapResponse.fromJson(jsonDecode(response.body));
        // Si la opcion optimizar esta activada cambio el orden de ruta.puntos
        // if (optimizar && azureMapResponse.optimizedWaypoints != null) {
        //   for (RutaPunto rp in optimizado) {
        //     log(rp.punto.direccion);
        //   }
        //   for (AzureOptimizedWaypoint m
        //       in azureMapResponse.optimizedWaypoints!) {
        //     optimizado[m.optimizedIndex] = ruta.puntos[m.providedIndex];
        //   }
        //   ruta.puntos = [...optimizado];
        //   for (RutaPunto rp in optimizado) {
        //     log("optimizado: ${rp.punto.direccion}");
        //   }
        // }
        // Inisializo _polylines
        _polylines = [];
        // Obtengo los datos de cada punto de la ruta

        for (AzureRoutes route in azureMapResponse.routes) {
          ruta.distancia = route.summary.lengthInMeters;
          ruta.tiempoTraslado = route.summary.travelTimeInSeconds;
          for (int i = 0; i < route.legs.length; i++) {
            // if (i <= ruta.puntos.length - 1) {
            //   ruta.puntos[i].tiempoTraslado =
            //       route.legs[i].summary.travelTimeInSeconds;
            //   ruta.puntos[i].distancia = route.legs[i].summary.lengthInMeters;
            // }
            for (AzurePoints p in route.legs[i].points) {
              _polylines.add(LatLng(p.latitude, p.longitude));
            }
          }
        }
      }
    } catch (e) {
      log("procesRoute - Error: $e");
    }
    // Si la respuesta no es correcta (200) devuelvo la ruta sin cambios
    return ruta;
  }
}
