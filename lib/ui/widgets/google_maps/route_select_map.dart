import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart' show Factory, kDebugMode, kIsWeb;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/detalle/detalle.dart';
import 'package:sgrsoft/ui/widgets/google_maps/lineas.dart';

class GoogleSelectRouteMap extends StatefulWidget {
  final double latitude;
  final double longitude;

  final List<PuntoRecoleccion> puntos;

  const GoogleSelectRouteMap(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.puntos})
      : super(key: key);

  @override
  GoogleSelectRouteMapState createState() => GoogleSelectRouteMapState();
}

class GoogleSelectRouteMapState extends State<GoogleSelectRouteMap> {
  Completer<GoogleMapController> mapController = Completer();
  late CameraUpdate getRouteBoundsCameraUpdate;

  bool loadIcon = false;
  bool loadPolyLines = false;

  bool loading = true;
  bool isUpdate = false;

  LatLng origen = const LatLng(-34.734501, -56.229366);
  LatLng destino = const LatLng(-34.725260, -56.201385);

  Map<PolylineId, Polyline> polylines = {};
  late BitmapDescriptor _markerIcon;

  void _onMapCreated(GoogleMapController controller) {
    isUpdate = true;
    mapController.complete(controller);
    Timer(const Duration(seconds: 1), () {
      centerMap();
      setState(() {});
    });
  }

  void centerMap() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(getRouteBoundsCameraUpdate);
    isUpdate = true;
  }

  void _setMarkerIcon() async {
    final imgPlatform = !kIsWeb && Platform.isAndroid ? "m" : "w";
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 1, size: Size(36, 36)),
        'assets/images/iconos/marker_$imgPlatform.png');
    setState(() {
      _markerIcon = _markerIcon;
      loadIcon = true;
    });
  }

  void _setPolylines(List<PuntoRecoleccion> puntos) async {
    polylines = await getPolylines(puntos);

    if (kDebugMode) {
      print('====> polylines.length: ${polylines.length}');
    }

    setState(() {
      polylines = polylines;
      loadPolyLines = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _setMarkerIcon();
    _setPolylines(widget.puntos);
    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    // mapController.dispose();
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

    if (kDebugMode) {
      print('====> polylines: ${polylines.values.toString()}');
      print('====> loading: ${loading.toString()}');
      print('====> loadIcon: ${loadIcon.toString()}');
      print('====> loadPolyLines: ${loadPolyLines.toString()}');
    }
    return !loading && loadPolyLines && loadIcon
        ? GoogleMap(
            onMapCreated: _onMapCreated,
            polylines: Set<Polyline>.of(polylines.values),
            // polylines: <Polyline>{
            //   Polyline(
            //       polylineId: const PolylineId("PolylineId"),
            //       points: <LatLng>[origen, destino],
            //       color: Colors.greenAccent,
            //       width: 5)
            // },
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
            // gestureRecognizers permite que el mapa se pueda arrastrar y hacer zoom sobre todo cuando hay un scrollview
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
