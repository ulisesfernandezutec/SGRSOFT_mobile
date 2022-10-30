import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/ui/widgets/app_bar.dart';

typedef OnSelectPosition = void Function(LatLng position);

class GoogleMapsSetPosition2 extends StatefulWidget {
  static const routeName = '/puntos_recoleccion/mapa2';

  const GoogleMapsSetPosition2({Key? key}) : super(key: key);

  @override
  GoogleMapsSetPosition2State createState() => GoogleMapsSetPosition2State();
}

class GoogleMapsSetPosition2State extends State<GoogleMapsSetPosition2> {
  late GoogleMapController mapController;

  bool loading = true;

  late BitmapDescriptor _markerIcon;

  Map<MarkerId, Marker> markers = {};

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

  // @override
  // void initState() {
  //   super.initState();
  //   _setMarkerIcon();
  // }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LatLng center = const LatLng(-33.8567844, 151.213108);
    if (kDebugMode) {
      print(markers.length.toString());
    }
    return !loading
        ? Scaffold(
            appBar: appBar(context),
            body: GoogleMap(
                onMapCreated: _onMapCreated,
                mapType: MapType.normal,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                scrollGesturesEnabled: true,
                rotateGesturesEnabled: true,
                tiltGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: 18.0,
                ),
                markers: Set<Marker>.of(markers.values),
                // markers: markers,
                onTap: (argument) {
                  if (kDebugMode) {
                    print(argument.toJson().toString());
                  }
                  // widget.onSelectPosition(
                  //     LatLng(argument.latitude, argument.longitude));

                  mapController.moveCamera(CameraUpdate.newLatLng(argument));

                  Map<MarkerId, Marker> markers = {};
                  markers[const MarkerId('asdd')] = Marker(
                      icon: BitmapDescriptor.defaultMarker,
                      position: argument,
                      markerId: const MarkerId('Punto de Recolección'));

                  if (kDebugMode) {
                    print(markers.length.toString());
                  }

                  setState(() {
                    markers = markers;
                  });
                }))
        : Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor));
  }
}
