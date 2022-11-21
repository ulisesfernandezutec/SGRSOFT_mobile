import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/ui/asset_store/image_store.dart';

typedef OnSelectPosition = void Function(LatLng position);

Marker createDragMarker(
    {required double latitude,
    required double longitude,
    required OnSelectPosition onSelectPosition}) {
  return Marker(
      markerId: const MarkerId('SelectectedMarker1'),
      position: LatLng(latitude, longitude),
      icon: ImageStore.markerIcon,
      draggable: true,
      onDragEnd: (position) {
        onSelectPosition(position);
      });
}

class GoogleMapPositionSelect extends StatefulWidget {
  final double latitude;
  final double longitude;
  final OnSelectPosition onSelectPosition;

  const GoogleMapPositionSelect(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.onSelectPosition});
  @override
  GoogleMapPositionSelectState createState() => GoogleMapPositionSelectState();
}

class GoogleMapPositionSelectState extends State<GoogleMapPositionSelect> {
  late GoogleMapController mapController;

  double latitude = 0;
  double longitude = 0;

  bool loading = true;

  Set<Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      latitude = widget.latitude;
      longitude = widget.longitude;
      loading = false;
      markers = <Marker>{
        createDragMarker(
            latitude: latitude,
            longitude: longitude,
            onSelectPosition: widget.onSelectPosition)
      };
    });
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LatLng center = LatLng(latitude, longitude);

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
            initialCameraPosition: CameraPosition(
              target: center,
              zoom: 18.0,
            ),
            markers: markers,
            onTap: (argument) async {
              widget.onSelectPosition(
                  LatLng(argument.latitude, argument.longitude));

              mapController.moveCamera(CameraUpdate.newLatLng(argument));
            },
          )
        : Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor));
  }
}
