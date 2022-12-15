import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/blocs/ruta/nueva/nueva_bloc.dart';
import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';
import 'package:sgrsoft/domain/models/punto_mapa.dart';
import 'package:sgrsoft/domain/models/punto_salida.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/ui/widgets/forms/app_combo_box.dart';
import 'package:sgrsoft/ui/widgets/google_maps/route_select_map.dart';
import 'package:sgrsoft/ui/widgets/util_ruta.dart';

UtilRuta utilRuta = UtilRuta();

class StepMap extends StatelessWidget {
  final Ruta ruta;
  final List<LatLng> polylines;
  final List<int> seleccionados;
  final ValueChanged<int> onChange;
  final List<PuntoMapa> puntos;
  final List<PuntoSalida> puntosSalida;
  final ValueChanged<int?>? onChangeSalida;
  final List<PuntoDisposicionFinal> puntosDisposicionFinal;
  final ValueChanged<int?>? onChangeDisposicionFinal;
  const StepMap(
      {Key? key,
      required this.ruta,
      required this.polylines,
      required this.seleccionados,
      required this.puntos,
      required this.puntosSalida,
      required this.puntosDisposicionFinal,
      required this.onChange,
      required this.onChangeSalida,
      required this.onChangeDisposicionFinal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 10, children: <Widget>[
      puntos.isNotEmpty
          ? Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              constraints: const BoxConstraints(
                  maxWidth: 550, minHeight: 200, minWidth: 200),
              child: Card(
                  elevation: 3,
                  child: GoogleSelectRouteMap(
                      latitude: 0,
                      longitude: 0,
                      onSelectMarker: onChange,
                      ruta: ruta,
                      puntos: puntos,
                      seleccionados: seleccionados,
                      selectedMarkerId: '',
                      polylines: polylines)))
          : Container(),
      Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          constraints: const BoxConstraints(maxWidth: 400), //, maxHeight: 500
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            AppComboBox(
              dataList: puntosSalida
                  .map((e) => {"id": e.id, "label": e.nombre})
                  .toList(),
              hint: "Seleccione un punto de salida",
              label: "Salida",
              selectedValue: ruta.salida?.id,
              comboKey: "id",
              comboLabel: "label",
              onChanged: onChangeSalida,
              validar: null,
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
            AppComboBox(
              dataList: puntosDisposicionFinal
                  .map((e) => {"id": e.id, "label": e.nombre})
                  .toList(),
              hint: "Seleccione un punto de disposición final",
              label: "Disposición final",
              selectedValue: ruta.disposicionFinal?.id,
              comboKey: "id",
              comboLabel: "label",
              onChanged: onChangeDisposicionFinal,
              validar: null,
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
            Column(children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                    children: [
                      const Text(
                        "Distancia: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(UtilRuta.getDistancia(ruta.distancia.toInt()))
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                    children: [
                      const Text("Tiempo: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(UtilRuta.getTiempo(ruta.tiempoTraslado.toInt()))
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: ruta.optimizar,
                          onChanged: (value) => {
                                BlocProvider.of<NuevaRutaBloc>(context).add(
                                    NuevaRutaEventChangeOptimizar(
                                        optimizar: !ruta.optimizar))
                              }),
                      TextButton(
                          onPressed: () => {
                                BlocProvider.of<NuevaRutaBloc>(context).add(
                                    NuevaRutaEventChangeOptimizar(
                                        optimizar: !ruta.optimizar))
                              },
                          child: const Text("Optimmizar ruta",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () => {
                                BlocProvider.of<NuevaRutaBloc>(context)
                                    .add(NuevaRutaEventSave())
                              },
                          child: const Text("Guardar ruta",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ))
            ])
          ]))),
    ]);
  }
}
