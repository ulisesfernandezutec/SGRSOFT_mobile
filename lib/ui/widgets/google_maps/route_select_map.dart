import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart'
    show Factory, Uint8List, kDebugMode, kIsWeb;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/blocs/ruta/nueva/nueva_bloc.dart';
import 'package:sgrsoft/domain/models/punto_mapa.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/ui/asset_store/image_store.dart';

typedef OnSelectMarker = void Function(int id);

class GoogleSelectRouteMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  final List<PuntoMapa> puntos;
  final OnSelectMarker onSelectMarker;
  final String selectedMarkerId;
  final List<int> seleccionados;
  final Ruta ruta;
  final List<LatLng> polylines;
  const GoogleSelectRouteMap(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.puntos,
      required this.onSelectMarker,
      required this.selectedMarkerId,
      required this.seleccionados,
      required this.ruta,
      required this.polylines});

  @override
  GoogleSelectRouteMapState createState() => GoogleSelectRouteMapState();
}

class GoogleSelectRouteMapState extends State<GoogleSelectRouteMap> {
  late GoogleMapController mapController;

  bool loading = true;
  bool isUpdate = false;

  late BitmapDescriptor _trashIcon;
  late BitmapDescriptor _trashInRouteIcon;
  late BitmapDescriptor _trashStartIcon;
  late BitmapDescriptor _trashEndIcon;

  final imgPlatform = !kIsWeb && Platform.isAndroid ? "m" : "w";

  void _onMapCreated(GoogleMapController controller) {
    isUpdate = true;
    mapController = controller;
    centerMap();
  }

  void centerMap() {
    double highestLat = -30.526438;
    double highestLong = -58.612754;
    double lowestLat = -34.780694;
    double lowestLong = -53.031861;

    if (widget.ruta.bound != null) {
      highestLat = widget.ruta.bound!.northeast!.lat ?? -30.526438;
      highestLong = widget.ruta.bound!.northeast!.lng ?? -58.612754;
      lowestLat = widget.ruta.bound!.southwest!.lat ?? -34.780694;
      lowestLong = widget.ruta.bound!.southwest!.lng ?? -53.031861;
    } else if (widget.puntos.isNotEmpty) {
      highestLat = widget.puntos.map((e) => e.latitud).reduce(max);
      highestLong = widget.puntos.map((e) => e.longitud).reduce(max);
      lowestLat = widget.puntos.map((e) => e.latitud).reduce(min);
      lowestLong = widget.puntos.map((e) => e.longitud).reduce(min);
    }

    final lowestLatLowestLong = LatLng(lowestLat, lowestLong);
    final highestLatHighestLong = LatLng(highestLat, highestLong);
    CameraUpdate getRouteBoundsCameraUpdate = CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: lowestLatLowestLong, northeast: highestLatHighestLong),
        25.0);
    mapController.animateCamera(getRouteBoundsCameraUpdate);
    isUpdate = true;
  }

  Future<BitmapDescriptor> _setMarkerInRouteIcon() async {
    final Uint8List icon = await ImageStore.getBytesFromAsset(
        'assets/images/iconos/trash_in_route_$imgPlatform.png', 24);
    final markerIcon = BitmapDescriptor.fromBytes(icon);
    return markerIcon;
  }

  Future<BitmapDescriptor> _setMarkerStartIcon() async {
    final Uint8List icon = await ImageStore.getBytesFromAsset(
        'assets/images/iconos/start_$imgPlatform.png', 24);
    final markerIcon = BitmapDescriptor.fromBytes(icon);
    return markerIcon;
  }

  Future<BitmapDescriptor> _setMarkerEndIcon() async {
    final Uint8List icon = await ImageStore.getBytesFromAsset(
        'assets/images/iconos/end_$imgPlatform.png', 24);
    final markerIcon = BitmapDescriptor.fromBytes(icon);
    return markerIcon;
  }

  Future<BitmapDescriptor> _setMarkerTrashIcon() async {
    final Uint8List icon = await ImageStore.getBytesFromAsset(
        'assets/images/iconos/trash_$imgPlatform.png', 24);
    final markerIcon = BitmapDescriptor.fromBytes(icon);
    return markerIcon;
  }

  Future<void> _setAllMarkerIcons(BuildContext context) async {
    BitmapDescriptor trashIcon = await _setMarkerTrashIcon();
    BitmapDescriptor trashInRouteIcon = await _setMarkerInRouteIcon();
    BitmapDescriptor trashStartIcon = await _setMarkerStartIcon();
    BitmapDescriptor trashEndIcon = await _setMarkerEndIcon();

    setState(() {
      _trashEndIcon = trashEndIcon;
      _trashIcon = trashIcon;
      _trashInRouteIcon = trashInRouteIcon;
      _trashStartIcon = trashStartIcon;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _setAllMarkerIcons(context);
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Set<Polyline> polylines = {};
    Set<Marker> markers = {};

    LatLng center = LatLng(widget.puntos[0].latitud, widget.puntos[0].longitud);

    if (!loading) {
      markers = Set.of(widget.puntos
          .map((e) => Marker(
                markerId: MarkerId(e.id.toString()),
                position: LatLng(e.latitud, e.longitud),
                icon: widget.seleccionados.contains(e.id)
                    ? _trashInRouteIcon
                    : _trashIcon,
                onTap: () {
                  widget.onSelectMarker(e.id);
                  BlocProvider.of<NuevaRutaBloc>(context)
                      .add(NuevaRutaEventChangePuntos(id: e.id));
                },
              ))
          .toList());

      if (widget.ruta.salida != null) {
        markers.add(Marker(
          markerId: const MarkerId('salida'),
          position:
              LatLng(widget.ruta.salida!.latitud, widget.ruta.salida!.longitud),
          icon: _trashStartIcon,
        ));
      }

      if (widget.ruta.disposicionFinal != null) {
        markers.add(Marker(
          markerId: const MarkerId('disposicion'),
          position: LatLng(widget.ruta.disposicionFinal!.latitud,
              widget.ruta.disposicionFinal!.longitud),
          icon: _trashEndIcon,
        ));
      }

      polylines = Set.of(widget.polylines
          .map((e) => Polyline(
              polylineId: const PolylineId("polylinesMap"),
              points: widget.polylines,
              color: Colors.lightGreen,
              width: 5))
          .toList());
    }

    return !loading
        ? GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            myLocationEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            scrollGesturesEnabled: true,
            polylines: polylines,
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
            markers: markers,
          )
        : Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor));
  }
}
