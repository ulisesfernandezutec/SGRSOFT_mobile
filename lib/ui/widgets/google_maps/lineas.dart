import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';

Future<Map<PolylineId, Polyline>> getPolylines(
    List<PuntoRecoleccion> puntos) async {
  // Object for PolylinePoints
  PolylinePoints polylinePoints = PolylinePoints();
  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  PuntoRecoleccion? last;
  for (PuntoRecoleccion p in puntos) {
    log(p.direccion);
    if (last != null) {
      // Create the list of coordinates to join
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        NetConts.getGoogleAPIKey(),
        PointLatLng(last.latitud, last.longitud),
        PointLatLng(p.latitud, p.longitud),
        travelMode: TravelMode.transit,
      );
      // log('result ${result.toString()}');

      if (result.points.isNotEmpty) {
        // loop through all PointLatLng points and convert them
        // to a list of LatLng, required by the Polyline
        for (var point in result.points) {
          // log('${point.latitude}, ${point.longitude}');
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      }
    }
    last = p;
  }
  // Defining an ID
  PolylineId id = const PolylineId('ruta');
  // Initializing Polyline
  Polyline polyline = Polyline(
    polylineId: id,
    color: Colors.red,
    points: polylineCoordinates,
    width: 3,
  );

  // Adding the polyline to the map
  polylines[id] = polyline;
  return polylines;
}
