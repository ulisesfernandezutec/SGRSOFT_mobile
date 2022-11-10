import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/ui/widgets/google_maps/route_select_map3.dart';

class StepMap extends StatelessWidget {
  final List<PuntoRecoleccion> puntos;
  final List<Polyline> polylines;
  final List<Marker> markers;
  const StepMap(
      {Key? key,
      required this.puntos,
      required this.polylines,
      required this.markers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(puntos.toString());
    return Wrap(children: <Widget>[
      SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: FlutterMapSelectRouteMap(
              puntos: puntos, polylines: polylines, markers: markers)),
      DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Dirección')),
            DataColumn(label: Text('Orden'))
          ],
          rows: puntos
              .map((e) => DataRow(cells: [
                    DataCell(Text(e.direccion)),
                    DataCell(Text(e.id.toString()))
                  ]))
              .toList()),
    ]);
  }
}
