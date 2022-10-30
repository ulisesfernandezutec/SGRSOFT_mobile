import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
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

  bool loading = true;

  late BitmapDescriptor _markerIcon;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _setMarkerIcon() async {
    final imgPlatform = !kIsWeb && Platform.isAndroid ? "m" : "w";
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 1, size: Size(48, 48)),
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
    final LatLng center = LatLng(widget.latitude, widget.longitude);
    if (kDebugMode) {
      print(widget.latitude.toString());
      print(widget.longitude.toString());
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
              zoom: 15.0,
            ),
            padding: const EdgeInsets.all(8),
            markers: Set.of(widget.puntos
                .map((e) => Marker(
                      markerId: MarkerId(e.id.toString()),
                      position: LatLng(e.latitud, e.longitud),
                      infoWindow: InfoWindow(
                        title: e.tipo.nombre,
                        snippet: e.direccion,
                      ),
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
