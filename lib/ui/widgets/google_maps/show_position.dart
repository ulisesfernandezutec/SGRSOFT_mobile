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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final LatLng center = LatLng(widget.latitude, widget.longitude);
    return !loading
        ? GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 18.0,
            ),
          )
        : Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor));
  }
}
