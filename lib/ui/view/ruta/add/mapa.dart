import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/ui/view/ruta/widgets/tabla.dart';
import 'package:sgrsoft/ui/widgets/google_maps/route_select_map2.dart';

class StepMap extends StatelessWidget {
  final List<PuntoRecoleccion> puntos;
  final Map<PolylineId, Polyline> polylines;
  final Set<Marker> markers;
  const StepMap(
      {Key? key,
      required this.puntos,
      required this.polylines,
      required this.markers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(puntos.toString());
    return Center(
        child: Wrap(runSpacing: 10, children: <Widget>[
      Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: GoogleSelectRouteMap2(
              puntos: puntos, polylines: polylines, markers: markers)),
      Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Column(children: <Widget>[
            RutasTabla(rutas: puntos),
            ElevatedButton(onPressed: () {}, child: const Text('Agregar'))
          ]))
    ]));
  }
}
