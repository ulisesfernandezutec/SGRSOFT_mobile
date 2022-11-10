import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/data/streams/puntos_recoleccion/listado.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/ui/asset_store/image_store.dart';
import 'package:sgrsoft/ui/widgets/google_maps/lineas.dart';

part 'event.dart';
part 'state.dart';

final getIt = GetIt.instance;

class AddRutaBloc extends Bloc<AddRutaEvent, AddRutaState> {
  final PuntosRecoleccionRepository _puntoRecoleccionRespository = getIt();

  AddRutaBloc() : super(AddRutaInitialState()) {
    on<LoadAddRutaEvent>((event, emit) async {
      await _init(event: event, emit: emit);
    });
  }

  Future<void> _init(
      {required AddRutaEvent event,
      required Emitter<AddRutaState> emit}) async {
    List<PuntoRecoleccion> puntos =
        await _puntoRecoleccionRespository.getList();
    List<Polyline> polylines = await getPolylines(puntos);
    List<Marker> markers = [];
    for (PuntoRecoleccion p in puntos) {
      markers.add(Marker(
        width: 120.0,
        height: 120.0,
        point: LatLng(p.latitud, p.longitud),
        builder: (context) => const Icon(
          Icons.location_pin,
          color: Colors.red,
          size: 48,
        ),
      ));
    }
    emit(AddRutaReadyState(
        puntosRecoleccion: puntos, polylines: polylines, markers: markers));
  }
}
