import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef OnSelectPosition = void Function(LatLng position);

class GoogleMapsSetPosition extends StatefulWidget {
  final double latitude;
  final double longitude;
  final Map<MarkerId, Marker> markers;
  final OnSelectPosition onSelectPosition;

  const GoogleMapsSetPosition(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.markers,
      required this.onSelectPosition})
      : super(key: key);

  @override
  GoogleMapsSetPositionState createState() => GoogleMapsSetPositionState();
}

class GoogleMapsSetPositionState extends State<GoogleMapsSetPosition> {
  late GoogleMapController mapController;

  bool loading = true;

  late BitmapDescriptor _markerIcon;

  Set<Marker> markers = {};

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
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            scrollGesturesEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            // gestureRecognizers permite que el mapa se pueda arrastrar y hacer zoom sobre todo cuando hay un scrollview
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            },
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 18.0,
            ),
            markers: Set<Marker>.of(widget.markers.values),
            // markers: markers,
            onTap: (argument) {
              if (kDebugMode) {
                print(argument.toJson().toString());
              }

              widget.onSelectPosition(
                  LatLng(argument.latitude, argument.longitude));

              mapController.moveCamera(CameraUpdate.newLatLng(argument));

              Set<Marker> markers = {};
              markers.add(Marker(
                  icon: _markerIcon,
                  position: argument,
                  markerId: const MarkerId('Punto de Recolección')));
            },
          )
        : Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor));
  }
}
