import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart' show Factory, kDebugMode, kIsWeb;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/detalle/detalle.dart';

class GoogleMapsShowAllPositions extends StatefulWidget {
  final double latitude;
  final double longitude;

  final List<PuntoRecoleccion> puntos;

  const GoogleMapsShowAllPositions(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.puntos})
      : super(key: key);

  @override
  GoogleMapsShowAllPositionsState createState() =>
      GoogleMapsShowAllPositionsState();
}

class GoogleMapsShowAllPositionsState
    extends State<GoogleMapsShowAllPositions> {
  late GoogleMapController mapController;
  late CameraUpdate getRouteBoundsCameraUpdate;

  bool loading = true;
  bool isUpdate = false;

  late BitmapDescriptor _markerIcon;

  void _onMapCreated(GoogleMapController controller) {
    isUpdate = true;
    mapController = controller;
    centerMap();
  }

  void centerMap() {
    mapController.animateCamera(getRouteBoundsCameraUpdate);
    isUpdate = true;
  }

  Future<void> _setMarkerIcon() async {
    final imgPlatform = !kIsWeb && Platform.isAndroid ? "m" : "w";
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 1, size: Size(36, 36)),
        'assets/images/iconos/marker_$imgPlatform.png');
    setState(() {
      loading = false;
      _markerIcon = _markerIcon;
    });
  }

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final highestLat = widget.puntos.map((e) => e.latitud).reduce(max);
    final highestLong = widget.puntos.map((e) => e.longitud).reduce(max);
    final lowestLat = widget.puntos.map((e) => e.latitud).reduce(min);
    final lowestLong = widget.puntos.map((e) => e.longitud).reduce(min);

    final lowestLatLowestLong = LatLng(lowestLat, lowestLong);
    final highestLatHighestLong = LatLng(highestLat, highestLong);

    getRouteBoundsCameraUpdate = CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: lowestLatLowestLong, northeast: highestLatHighestLong),
        25.0);

    LatLng center = LatLng(widget.puntos[0].latitud, widget.puntos[0].longitud);
    widget.puntos.map((e) => print('${e.direccion.toString()} \n'));

    for (PuntoRecoleccion p in widget.puntos) {
      if (kDebugMode) {
        print(
            '${p.direccion.toString()} => [${p.latitud.toString()},${p.longitud.toString()}] \n');
      }
    }
    return !loading
        ? GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            myLocationEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            scrollGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 12.0,
            ),
            padding: const EdgeInsets.all(8),
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            markers: Set.of(widget.puntos
                .map((e) => Marker(
                      markerId: MarkerId(e.id.toString()),
                      position: LatLng(e.latitud, e.longitud),
                      // infoWindow: InfoWindow(
                      //   title: e.tipo.nombre,
                      //   snippet: e.direccion,
                      // ),
                      icon: _markerIcon,
                      onTap: () {
                        Navigator.pushNamed(
                            context, DetallePuntosRecoleccionScreens.routeName,
                            arguments:
                                DetallePuntoRecoleccionArguments(id: e.id));
                      },
                    ))
                .toList()),
          )
        : Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor));
  }
}
