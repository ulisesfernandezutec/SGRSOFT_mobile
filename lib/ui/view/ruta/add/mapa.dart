import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/domain/blocs/ruta/add/bloc.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion_estado.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';
import 'package:sgrsoft/ui/view/ruta/widgets/tabla.dart';
import 'package:sgrsoft/ui/widgets/google_maps/route_select_map2.dart';

class StepMap extends StatelessWidget {
  // final List<PuntoRecoleccion> puntos;
  final Ruta ruta;
  final Map<PolylineId, Polyline> polylines;
  final List<Marker> markers;
  const StepMap(
      {Key? key,
      // required this.puntos,
      required this.ruta,
      required this.polylines,
      required this.markers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Wrap(runSpacing: 10, children: <Widget>[
      ruta.puntos.isNotEmpty
          ? Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: GoogleSelectRouteMap2(
                  ruta: ruta, polylines: polylines, markers: markers))
          : Container(),
      Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Column(children: <Widget>[
            RutasTabla(ruta: ruta),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AddRutaBloc>(context).add(
                      AgregarPuntoAddRutaEvent(
                          puntoRecoleccion: PuntoRecoleccion(
                              id: 0,
                              latitud: 0.0,
                              longitud: 0.0,
                              tipo: TipoDeResiduo(id: 0, nombre: ""),
                              direccion: "",
                              descripcion: "",
                              estados: const <PuntoRecoleccionEstado>[])));
                },
                child: const Text('Agregar'))
          ]))
    ]));
  }
}
