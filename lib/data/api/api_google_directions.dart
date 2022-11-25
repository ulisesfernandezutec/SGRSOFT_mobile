import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/data/repository/utils/add_ruta.dart';
import 'package:sgrsoft/domain/models/google_directions/google_direction.dart';
import 'package:sgrsoft/domain/models/google_directions/google_route.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/domain/models/ruta_punto.dart';

class ApiGoogleDirections {
  AddRutaRepository rutaRepository;
  GoogleDirection? googleDirection;

  ApiGoogleDirections({required this.rutaRepository});

  Future<void> getGoogleDirections() async {
    List<RutaPunto> puntos = rutaRepository.ruta.puntos;
    if (puntos.length > 1) {
      LatLng origin = LatLng(puntos[0].punto.latitud, puntos[0].punto.longitud);
      LatLng destination = LatLng(puntos[puntos.length - 1].punto.latitud,
          puntos[puntos.length - 1].punto.longitud);

      log('origin.toString(): ${origin.latitude},${origin.longitude}');
      var url = Uri.parse(NetConts.GOOGLE_URL_DIRECTIONS);
      Map<String, String> queryParameters = {};
      queryParameters['origin'] = "${origin.latitude},${origin.longitude}";
      queryParameters['destination'] =
          "${destination.latitude},${destination.longitude}";
      queryParameters['key'] = NetConts.getGoogleAPIKey();
      queryParameters['language'] = 'es';
      queryParameters['mode'] = 'DRIVING';

      List<String> waypointsString = [];
      for (int i = 1; i < puntos.length - 1; i++) {
        waypointsString
            .add("${puntos[i].punto.latitud},${puntos[i].punto.longitud}");
      }

      if (puntos.length > 2) {
        queryParameters['waypoints'] = waypointsString.join('|');
      }

      print(Uri.https(url.host, url.path, queryParameters)
          .toString()
          .replaceAll("%2C", ","));
      Dio dio = Dio();
      await dio
          .get(Uri.https(url.host, url.path, queryParameters)
              .toString()
              .replaceAll("%2C", ","))
          .then((value) {
        log("value.data: ${value.data}");
        googleDirection = GoogleDirection.fromJson(value.data);
        log("googleDirection.toString(): ${googleDirection.toString()}");
      });
    }
  }

  Ruta getRuta() {
    Ruta ruta = rutaRepository.ruta;
    if (googleDirection != null) {
      ruta.bound = googleDirection?.routes[0].bounds;

      for (GoogleRoute r in googleDirection!.routes) {
        for (int i = 0; i < r.legs.length; i++) {
          ruta.puntos[i].googleDistance = r.legs[i].distance;
          ruta.puntos[i].googleDuration = r.legs[i].duration;
        }
      }
    }
    rutaRepository.updateRuta(ruta);
    return ruta;
  }

  ///decode the google encoded string using Encoded Polyline Algorithm Format
  /// for more info about the algorithm check https://developers.google.com/maps/documentation/utilities/polylinealgorithm
  ///
  ///return [List]
  List<LatLng> decodeEncodedPolyline() {
    List<LatLng> poly = [];
    if (googleDirection != null) {
      String encoded =
          googleDirection?.routes[0].overviewPolyline!.points ?? '';

      int index = 0, len = encoded.length;
      int lat = 0, lng = 0;

      while (index < len) {
        int b, shift = 0, result = 0;
        do {
          b = encoded.codeUnitAt(index++) - 63;
          result |= (b & 0x1f) << shift;
          shift += 5;
        } while (b >= 0x20);
        int dlat = ((result & 1) != 0 ? -1 * (result >> 1) - 1 : (result >> 1));
        lat += dlat;

        shift = 0;
        result = 0;
        do {
          b = encoded.codeUnitAt(index++) - 63;
          result |= (b & 0x1f) << shift;
          shift += 5;
        } while (b >= 0x20);
        int dlng = ((result & 1) != 0 ? -1 * (result >> 1) - 1 : (result >> 1));
        lng += dlng;
        LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
        poly.add(p);
      }
    }
    return poly;
  }
}
