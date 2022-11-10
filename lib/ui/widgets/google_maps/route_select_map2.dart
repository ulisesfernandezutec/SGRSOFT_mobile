import 'dart:async';
import 'package:flutter/foundation.dart' show Factory;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/ui/widgets/google_maps/lineas.dart';

class GoogleSelectRouteMap2 extends StatefulWidget {
  final List<PuntoRecoleccion> puntos;
  final Set<Polyline> polylines;
  final Set<Marker> markers;

  const GoogleSelectRouteMap2(
      {Key? key,
      required this.puntos,
      required this.polylines,
      required this.markers})
      : super(key: key);

  @override
  GoogleSelectRouteMap2State createState() => GoogleSelectRouteMap2State();
}

class GoogleSelectRouteMap2State extends State<GoogleSelectRouteMap2> {
  // Map Controller to control the map
  Completer<GoogleMapController> mapController = Completer();

  // Vars
  List<PuntoRecoleccion> puntos = [];
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  late CameraUpdate getRouteBoundsCameraUpdate;

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    Timer(const Duration(seconds: 1), () async {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      mapType: MapType.normal,
      myLocationEnabled: false,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      scrollGesturesEnabled: true,
      polylines: widget.polylines,
      initialCameraPosition: const CameraPosition(
        target: LatLng(-34.734501, -56.229366),
        zoom: 12.0,
      ),
      padding: const EdgeInsets.all(8),
      // gestureRecognizers permite que el mapa se pueda arrastrar y hacer zoom sobre todo cuando hay un scrollview
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
      markers: widget.markers,
    );
  }
}
