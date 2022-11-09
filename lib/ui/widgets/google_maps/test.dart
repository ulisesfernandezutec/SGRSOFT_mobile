import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sgrsoft/data/const/netconsts.dart';

class PolylineMap extends StatefulWidget {
  static const routeName = '/polyline_map';

  const PolylineMap({super.key});
  @override
  _PolylineMapState createState() => _PolylineMapState();
}

class _PolylineMapState extends State<PolylineMap> {
  late GoogleMapController mapController;

  static const double _originLatitude = -34.738538,
      _originLongitude = -56.226759;
  static const double _destLatitude = -34.894089, _destLongitude = -56.186176;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  NetConts netConts = NetConts();
  late String googleAPiKey;

  LatLng origen = const LatLng(-34.734501, -56.229366);
  LatLng destino = const LatLng(-34.725260, -56.201385);

  @override
  void initState() {
    super.initState();
    log('initState()');
    if (kDebugMode) {
      print('initState()');
    }
    setState(() {
      googleAPiKey = netConts.getGoogleAPIKey();
    });

    /// origin marker
    _addMarker(const LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(const LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: LatLng(50.10, 14.25), zoom: 10),
        polylines: <Polyline>{
          Polyline(
              polylineId: const PolylineId("PolylineId"),
              points: <LatLng>[origen, destino],
              color: Colors.red,
              width: 5)
        },
        // polygons: {
        //   const Polygon(
        //     polygonId: PolygonId("polygon"),
        //     points: [
        //       LatLng(50.40, 14.10),
        //       LatLng(50.10, 14.10),
        //       LatLng(50.10, 14.50),
        //       LatLng(50.40, 14.50),
        //     ],
        //   )
        // },
        onTap: (latLng) {
          print("NOT fired when clicked on Polygon");
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(polylineId: id, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    log('_getPolyline()');
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      netConts.getGoogleAPIKey(),
      const PointLatLng(_originLatitude, _originLongitude),
      const PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
      // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    log(result.toString());
    if (result.points.isNotEmpty) {
      log('message: ${result.points.length.toString()}');
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }
}
