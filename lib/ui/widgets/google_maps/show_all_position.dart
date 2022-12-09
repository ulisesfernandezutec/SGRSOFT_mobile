import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart'
    show Factory, Uint8List, kDebugMode, kIsWeb;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/ui/asset_store/image_store.dart';
import 'package:sgrsoft/ui/view/puntos_recoleccion/detalle/detalle.dart';
import 'package:aligned_dialog/aligned_dialog.dart';

typedef OnSelectMarker = void Function(String id);

class GoogleMapsShowAllPositions extends StatefulWidget {
  final double latitude;
  final double longitude;
  final List<PuntoRecoleccion> puntos;
  final OnSelectMarker onSelectMarker;
  final String selectedMarkerId;

  const GoogleMapsShowAllPositions(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.puntos,
      required this.onSelectMarker,
      required this.selectedMarkerId});

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
  late BitmapDescriptor _markerSelectIcon;

  final imgPlatform = !kIsWeb && Platform.isAndroid ? "m" : "w";

  void _onMapCreated(GoogleMapController controller) {
    isUpdate = true;
    mapController = controller;
    centerMap();
  }

  void centerMap() {
    mapController.animateCamera(getRouteBoundsCameraUpdate);
    isUpdate = true;
  }

  Future<void> _setMarkerSelectIcon(BuildContext context) async {
    final Uint8List icon = await ImageStore.getBytesFromAsset(
        'assets/images/iconos/bandera_$imgPlatform.png', 36, context);
    final markerIcon = BitmapDescriptor.fromBytes(icon);
    setState(() {
      loading = false;
      _markerSelectIcon = markerIcon;
    });
  }

  Future<void> _setMarkerIcon(BuildContext context) async {
    // final Uint8List icon = await ImageStore.getBytesFromAsset(
    //     'assets/images/iconos/marker_$imgPlatform.png', 36, context);
    final Uint8List icon = await ImageStore.getBytesFromAsset(
        'assets/images/iconos/pin_$imgPlatform.png', 36, context);
    final markerIcon = BitmapDescriptor.fromBytes(icon);
    setState(() {
      // loading = false;
      _markerIcon = markerIcon;
    });
  }

  @override
  void initState() {
    super.initState();
    _setMarkerIcon(context);
    _setMarkerSelectIcon(context);
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
                      icon: widget.selectedMarkerId == e.id.toString()
                          ? _markerSelectIcon
                          : _markerIcon,
                      onTap: () {
                        widget.onSelectMarker(e.id.toString());
                        // showAlignedDialog(
                        //     context: context,
                        //     builder: _localDialogBuilder,
                        //     followerAnchor: Alignment.topLeft,
                        //     isGlobal: true,
                        //     transitionsBuilder: (BuildContext context,
                        //         Animation<double> animation,
                        //         Animation<double> secondaryAnimation,
                        //         Widget child) {
                        //       return SlideTransition(
                        //         position: Tween(
                        //                 begin: const Offset(-1, 0),
                        //                 end: const Offset(0, 0))
                        //             .animate(animation),
                        //         child: FadeTransition(
                        //           opacity: CurvedAnimation(
                        //             parent: animation,
                        //             curve: Curves.easeOut,
                        //           ),
                        //           child: child,
                        //         ),
                        //       );
                        //     });
                        // Navigator.pushNamed(
                        //     context, DetallePuntosRecoleccionScreens.routeName,
                        //     arguments:
                        //         DetallePuntoRecoleccionArguments(id: e.id));
                      },
                    ))
                .toList()),
          )
        : Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor));
  }
}

WidgetBuilder get _localDialogBuilder {
  return (BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            color: Colors.amberAccent,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 18, color: Colors.black87),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Tap to close")),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {
                      print("hello2");
                      //Navigator.of(context).pop();
                    },
                    child: const Text("Tap to print")),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  };
}
