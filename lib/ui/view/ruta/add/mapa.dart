import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/ui/widgets/google_maps/route_select_map.dart';

class StepMap extends StatelessWidget {
  final List<PuntoRecoleccion> puntos;
  const StepMap({Key? key, required this.puntos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(puntos.toString());
    return Wrap(children: <Widget>[
      SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: GoogleSelectRouteMap(
            puntos: puntos,
            latitude: 0,
            longitude: 0,
          )),
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
