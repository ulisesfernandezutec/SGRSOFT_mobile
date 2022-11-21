import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/detalle/detalle.dart';

const maxMarkersCount = 5000;

class MapWidget extends StatefulWidget {
  final LatLng? center;
  final bool edit;
  final List<Marker> markers;
  final List<PuntoRecoleccion> puntos;
  const MapWidget(
      {Key? key,
      this.center,
      this.edit = false,
      this.markers = const <Marker>[],
      this.puntos = const <PuntoRecoleccion>[]})
      : super(key: key);

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
  List<Marker> allMarkers = [];

  final int _sliderVal = maxMarkersCount ~/ 10;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final r = Random();
      for (var x = 0; x < maxMarkersCount; x++) {
        allMarkers.add(
          Marker(
            point: LatLng(
              doubleInRange(r, 37, 55),
              doubleInRange(r, -9, 30),
            ),
            builder: (context) => const Icon(
              Icons.location_pin,
              color: Colors.greenAccent,
              size: 12,
            ),
          ),
        );
      }
      setState(() {});
    });
  }

  Marker defaultMarker(PuntoRecoleccion punto) {
    return Marker(
        point: LatLng(punto.latitud, punto.longitud),
        builder: (context) => IconButton(
            icon: const Icon(
              Icons.location_pin,
              color: Colors.amber,
              size: 48,
            ),
            onPressed: () => {
                  Navigator.pushNamed(
                      context, DetallePuntosRecoleccionScreens.routeName,
                      arguments: DetallePuntoRecoleccionArguments(id: punto.id))
                }));
  }

  @override
  Widget build(BuildContext context) {
    //
    LatLngBounds? bounds;
    LatLng? center;

    List<Marker> listMarkers = <Marker>[];
    if (widget.puntos.isNotEmpty) {
      double minLat = widget.puntos[0].latitud;
      double maxLat = widget.puntos[0].latitud;
      double minLon = widget.puntos[0].longitud;
      double maxLon = widget.puntos[0].longitud;

      for (var p in widget.puntos) {
        listMarkers.add(defaultMarker(p));
        if (p.latitud < minLat) minLat = p.latitud;
        if (p.latitud > maxLat) maxLat = p.latitud;
        if (p.longitud < minLon) minLon = p.longitud;
        if (p.longitud > maxLon) maxLon = p.longitud;
      }

      // bounds = LatLngBounds(
      //   LatLng(minLat, minLon),
      //   LatLng(maxLat, maxLon),
      // );

      center = LatLng((minLat + maxLat) / 2, (minLon + maxLon) / 2);
    } else {
      center = widget.center ?? LatLng(-34.603722, -58.381592);
    }

    MapOptions options = MapOptions(
      // zoom: 13.0,
      maxZoom: 19.0,
      interactiveFlags: InteractiveFlag.all - InteractiveFlag.rotate,
      center: center,
      // bounds: bounds,
      // boundsOptions: const FitBoundsOptions(
      //     padding: EdgeInsets.all(30), maxZoom: 19.0, inside: true)
    );

    return Column(
      children: [
        Flexible(
          child: FlutterMap(
            options: options,
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                //urlTemplate: 'https://www.google.com/maps/vt/pb=!1m4!1m3!1i{z}!2i{x}!3i{y}!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425'
                // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
              ),
              MarkerLayer(
                  markers: listMarkers.sublist(
                      0, min(listMarkers.length, _sliderVal))),
            ],
          ),
        ),
      ],
    );
  }
}
