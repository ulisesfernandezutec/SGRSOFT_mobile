import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show Factory, Uint8List, kIsWeb;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/blocs/ruta/nueva/nueva_bloc.dart';
import 'package:sgrsoft/domain/models/punto_mapa.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/ui/asset_store/image_store.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

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
  Set<Marker> markers = {};
  final imgPlatform = !kIsWeb && Platform.isAndroid ? "m" : "w";

  void _onMapCreated(GoogleMapController controller) {
    isUpdate = true;
    mapController = controller;
    // centerMap();
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
  // Future<BitmapDescriptor> _setMarkerInRouteIcon(String numero) async {
  //   return await bitmapDescriptorFromSvgAsset(context, "numero");
  // }

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
    BitmapDescriptor trashStartIcon = await _setMarkerStartIcon();
    BitmapDescriptor trashEndIcon = await _setMarkerEndIcon();
    BitmapDescriptor trashInRouteIcon = await _setMarkerInRouteIcon();

    setState(() {
      _trashEndIcon = trashEndIcon;
      _trashIcon = trashIcon;
      _trashInRouteIcon = trashInRouteIcon;
      _trashStartIcon = trashStartIcon;
      loading = false;
    });
  }

  // Future<void> _setAllSelectedMarkers(BuildContext context) async {
  //   int inroute = 0;
  //   for (var i = 0; i < widget.puntos.length; i++) {
  //     if (widget.seleccionados.contains(widget.puntos[i].id)) {
  //       inroute++;
  //       markers.add(Marker(
  //         markerId: MarkerId(widget.puntos[i].id.toString()),
  //         position: LatLng(widget.puntos[i].latitud, widget.puntos[i].longitud),
  //         icon: await _setMarkerInRouteIcon(inroute.toString()),
  //         onTap: () {
  //           widget.onSelectMarker(widget.puntos[i].id);
  //           BlocProvider.of<NuevaRutaBloc>(context)
  //               .add(NuevaRutaEventChangePuntos(id: widget.puntos[i].id));
  //         },
  //       ));
  //     } else {
  //       markers.add(Marker(
  //         markerId: MarkerId(widget.puntos[i].id.toString()),
  //         position: LatLng(widget.puntos[i].latitud, widget.puntos[i].longitud),
  //         icon: _trashIcon,
  //         onTap: () {
  //           widget.onSelectMarker(widget.puntos[i].id);
  //           BlocProvider.of<NuevaRutaBloc>(context)
  //               .add(NuevaRutaEventChangePuntos(id: widget.puntos[i].id));
  //         },
  //       ));
  //     }
  //   }
  //   setState(() {
  //     markers = markers;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _setAllMarkerIcons(context);
    // _setAllSelectedMarkers(context);
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Set<Polyline> polylines = {};
    // Set<Marker> markers = {};

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

      for (var i = 0; i < widget.puntos.length; i++) {
        if (widget.seleccionados.contains(widget.puntos[i].id)) {
          continue;
        } else {
          markers.add(Marker(
            markerId: MarkerId(widget.puntos[i].id.toString()),
            position:
                LatLng(widget.puntos[i].latitud, widget.puntos[i].longitud),
            icon: _trashIcon,
            onTap: () {
              widget.onSelectMarker(widget.puntos[i].id);
              BlocProvider.of<NuevaRutaBloc>(context)
                  .add(NuevaRutaEventChangePuntos(id: widget.puntos[i].id));
            },
          ));
        }
      }

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
              color: Colors.blue,
              width: 3))
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

Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
    BuildContext context, String numero) async {
  // Read SVG file as String
  // String svgString = await DefaultAssetBundle.of(context).loadString(assetName,);
  // Create DrawableRoot from SVG String
  String svgStrings = '''<svg
   width="88.797264mm"
   height="87.137642mm"
   viewBox="0 0 88.797264 87.137642"
   version="1.1"
   id="svg5901"
   inkscape:version="1.2.2 (b0a8486541, 2022-12-01, custom)"
   sodipodi:docname="mark_circulo.svg"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:svg="http://www.w3.org/2000/svg">
  <sodipodi:namedview
     id="namedview5903"
     pagecolor="#ffffff"
     bordercolor="#000000"
     borderopacity="0.25"
     inkscape:showpageshadow="2"
     inkscape:pageopacity="0.0"
     inkscape:pagecheckerboard="0"
     inkscape:deskcolor="#d1d1d1"
     inkscape:document-units="mm"
     showgrid="false"
     inkscape:zoom="0.75722503"
     inkscape:cx="290.53451"
     inkscape:cy="520.98119"
     inkscape:window-width="1920"
     inkscape:window-height="1016"
     inkscape:window-x="0"
     inkscape:window-y="27"
     inkscape:window-maximized="1"
     inkscape:current-layer="layer1" />
  <defs
     id="defs5898">
    <rect
       x="258.82733"
       y="277.77771"
       width="190.01788"
       height="124.15714"
       id="rect11277" />
  </defs>
  <g
     inkscape:label="Capa 1"
     inkscape:groupmode="layer"
     id="layer1"
     transform="translate(-1.2451195,-1.3173393)">
    <ellipse
       style="fill:#009a5c;fill-opacity:1;stroke:#000000;stroke-width:1.075;stroke-dasharray:none;stroke-opacity:1"
       id="path6022"
       cx="45.643753"
       cy="44.886162"
       rx="43.861134"
       ry="43.031322" />
    <text
       xml:space="preserve"
       transform="scale(0.26458333)"
       id="text11275"
       style="white-space:pre;shape-inside:url(#rect11277);display:inline;fill:#009a5c;fill-opacity:1;stroke:#000000;stroke-width:0.662;stroke-opacity:1" />
    <text
       xml:space="preserve"
       style="font-size:33.8241px;fill:#fbfffe;fill-opacity:1;stroke:#ffffff;stroke-width:1.86594;stroke-opacity:1"
       x="15.529312"
       y="52.650452"
       id="text11283"
       transform="scale(0.90986231,1.0990674)"><tspan
         sodipodi:role="line"
         id="tspan11281"
         style="fill:#fbfffe;fill-opacity:1;stroke:#ffffff;stroke-width:1.86594;stroke-opacity:1"
         x="15.529312"
         y="52.650452">$numero</tspan></text>
  </g>
</svg>''';
  DrawableRoot svgDrawableRoot = await svg.fromSvgString(
    svgStrings,
    "svg",
  );

  // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
  // ignore: use_build_context_synchronously
  MediaQueryData queryData = MediaQuery.of(context);
  double devicePixelRatio = queryData.devicePixelRatio;
  double width = 32 * devicePixelRatio; // where 32 is your SVG's original width
  double height = 32 * devicePixelRatio; // same thing

  // Convert to ui.Picture
  ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

  // Convert to ui.Image. toImage() takes width and height as parameters
  // you need to find the best size to suit your needs and take into account the
  // screen DPI
  ui.Image image = await picture.toImage(width.toInt(), height.toInt());
  ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
}
