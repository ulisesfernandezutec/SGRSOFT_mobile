import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsShowPosition extends StatefulWidget {
  final double latitude;
  final double longitude;

  const GoogleMapsShowPosition(
      {Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  GoogleMapsShowPositionState createState() => GoogleMapsShowPositionState();
}

class GoogleMapsShowPositionState extends State<GoogleMapsShowPosition> {
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
              zoom: 18.0,
            ),
            padding: const EdgeInsets.all(8),
            markers: {
              Marker(
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueGreen,
                ), //_markerIcon,
                position: center,
                markerId: const MarkerId('Punto de Recolección'),
              )
            },
          )
        : Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor));
  }
}
