import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

Future<List<Polyline>> getPolylines(List<PuntoRecoleccion> puntos) async {
  NetConts netConts = NetConts();
  // Object for PolylinePoints
  PolylinePoints polylinePoints = PolylinePoints();
  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
  List<Polyline> polylines = [];

  PuntoRecoleccion? last;
  for (PuntoRecoleccion p in puntos) {
    log(p.direccion);
    if (last != null) {
      // Create the list of coordinates to join

      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        netConts.getGoogleAPIKey(),
        PointLatLng(last.latitud, last.longitud),
        PointLatLng(p.latitud, p.longitud),
        travelMode: TravelMode.transit,
      );
      log('result ${result.toString()}');

      if (result.points.isNotEmpty) {
        // loop through all PointLatLng points and convert them
        // to a list of LatLng, required by the Polyline
        for (var point in result.points) {
          log('latlon: ${point.latitude}, ${point.longitude}');
          log('point: ${point.toString()}');
          try {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          } catch (e) {
            log('error');
            log('e.lat ${point.latitude}');
            log('e.lng ${point.longitude}');
          }
        }
      }
    }
    last = p;
  }
  // Initializing Polyline
  Polyline polyline = Polyline(
    color: Colors.greenAccent,
    points: polylineCoordinates,
    strokeWidth: 3,
  );
  polylines.add(polyline);
  // Adding the polyline to the map
  return polylines;
}
