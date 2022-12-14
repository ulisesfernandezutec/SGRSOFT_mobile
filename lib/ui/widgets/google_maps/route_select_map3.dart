import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';

class FlutterMapSelectRouteMap extends StatefulWidget {
  final List<PuntoRecoleccion> puntos;
  final List<Polyline> polylines;
  final List<Marker> markers;

  const FlutterMapSelectRouteMap(
      {Key? key,
      required this.puntos,
      required this.polylines,
      required this.markers})
      : super(key: key);

  @override
  FlutterMapSelectRouteMapState createState() =>
      FlutterMapSelectRouteMapState();
}

class FlutterMapSelectRouteMapState extends State<FlutterMapSelectRouteMap> {
  // Map controller
  final mapController = MapController();

  // Vars
  List<PuntoRecoleccion> puntos = [];
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

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
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: LatLng(-34.734501, -56.229366),
        zoom: 13.0,
        maxZoom: 19.0,
        // bounds: LatLngBounds(
        //   LatLng(51.74920, -0.56741),
        //   LatLng(51.25709, 0.34018),
        // ),
        // maxBounds: LatLngBounds(
        //   LatLng(-90, -180.0),
        //   LatLng(90.0, 180.0),
        // ),
        keepAlive: true,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          // retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0
        ),
        PolylineLayer(
          polylineCulling: false,
          polylines: widget.polylines,
        ),
        MarkerLayer(markers: widget.markers)
      ],
    );
  }
}
