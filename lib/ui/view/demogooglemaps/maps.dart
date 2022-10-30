import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/device/dev_geolocator.dart';

class MyGoogleMaps extends StatefulWidget {
  const MyGoogleMaps({Key? key}) : super(key: key);

  static const String routeName = "/google_maps";

  @override
  MyGoogleMapsState createState() => MyGoogleMapsState();
}

class MyGoogleMapsState extends State<MyGoogleMaps> {
  late GoogleMapController mapController;

  bool loading = true;
  LatLng _center = const LatLng(-12.046374, -77.042793);

  @override
  void initState() {
    super.initState();
    () async {
      Position position = await determinePosition();
      setState(() {
        _center = LatLng(position.latitude, position.longitude);
        loading = false;
      });
    }();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: !loading
            ? GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 18.0,
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor)),
      ),
    );
  }
}
