import 'dart:async';
import 'package:flutter/foundation.dart' show Factory;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/models/ruta.dart';

class GoogleSelectRouteMap2 extends StatelessWidget {
  final Ruta ruta;
  final Map<PolylineId, Polyline> polylines;
  final List<Marker> markers;

  GoogleSelectRouteMap2(
      {super.key,
      required this.ruta,
      required this.polylines,
      required this.markers});

  // Map Controller to control the map
  Completer<GoogleMapController> mapController = Completer();

  CameraUpdate getCameraUpdate() {
    CameraUpdate getRouteBoundsCameraUpdate = CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: ruta.bound?.southwestLatLng ??
                const LatLng(-34.773527, -58.367394),
            northeast: ruta.bound?.northeastLatLng ??
                const LatLng(-30.156362, -53.273955)),
        100);
    return getRouteBoundsCameraUpdate;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    if (ruta.bound != null) {
      Timer(const Duration(seconds: 1), () async {
        centerMap();
      });
    }
  }

  void centerMap() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(getCameraUpdate());
  }

  @override
  Widget build(BuildContext context) {
    LatLng initialPosition = const LatLng(-34.773527, -58.367394);
    if (ruta.puntos!.isNotEmpty) {
      initialPosition = LatLng(
          ruta.puntos!.first.punto.latitud, ruta.puntos!.first.punto.longitud);
    }

    return GoogleMap(
      onMapCreated: _onMapCreated,
      mapType: MapType.normal,
      myLocationEnabled: false,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      scrollGesturesEnabled: true,
      polylines: Set.of(polylines.values),
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 12.0,
      ),
      padding: const EdgeInsets.all(8),
      // gestureRecognizers permite que el mapa se pueda arrastrar y hacer zoom sobre todo cuando hay un scrollview
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
      markers: Set.of(markers),
    );
  }
}
