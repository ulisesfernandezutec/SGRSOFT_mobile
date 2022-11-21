// ignore: depend_on_referenced_packages
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/data/api/api_google_directions.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/data/repository/utils/add_ruta.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/domain/models/ruta_punto.dart';
import 'package:sgrsoft/ui/asset_store/image_store.dart';

part 'event.dart';
part 'state.dart';

final getIt = GetIt.instance;

class AddRutaBloc extends Bloc<AddRutaEvent, AddRutaState> {
  final PuntosRecoleccionRepository _puntoRecoleccionRespository = getIt();
  final AddRutaRepository _addRutaRepository = getIt();
  ApiGoogleDirections api = ApiGoogleDirections(rutaRepository: getIt());

  AddRutaBloc() : super(AddRutaInitialState()) {
    on<LoadAddRutaEvent>((event, emit) async {
      _addRutaRepository.clear();
      emit(AddRutaInitialState());
    });
    on<AgregarPuntoAddRutaEvent>((event, emit) async {
      emit(const AddRutaLoadState());
      await _add(puntoRecoleccion: event.puntoRecoleccion, emit: emit);
    });
    on<ActualizarAddRutaEvent>((event, emit) async {
      emit(const AddRutaLoadState());
      await _update(puntos: event.puntos, emit: emit);
    });
  }

  Future<void> _add(
      {required PuntoRecoleccion puntoRecoleccion,
      required Emitter<AddRutaState> emit}) async {
    Ruta ruta = _addRutaRepository.ruta;
    List<PuntoRecoleccion> puntos =
        await _puntoRecoleccionRespository.getList();

    List<Marker> markers = [];
    Map<PolylineId, Polyline> polylines = {};

    int index = ruta.puntos.length;
    ruta.puntos.add(RutaPunto(punto: puntos[index]));

    if (ruta.puntos.length >= 2) {
      await api.getGoogleDirections();
      ruta = api.getRuta();

      // Defining an ID
      PolylineId id = const PolylineId('ruta');
      // Initializing Polyline
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: api.decodeEncodedPolyline(),
        width: 3,
      );

      // Adding the polyline to the map
      polylines = {};
      polylines[id] = polyline;
    }

    for (RutaPunto p in ruta.puntos) {
      markers.add(Marker(
        markerId: MarkerId(p.punto.id.toString()),
        position: LatLng(p.punto.latitud, p.punto.longitud),
        icon: ImageStore.markerIcon,
      ));
      log(p.punto.direccion);
    }

    emit(AddRutaReadyState(polylines: polylines, markers: markers, ruta: ruta));
  }

  Future<void> _update(
      {required List<RutaPunto> puntos,
      required Emitter<AddRutaState> emit}) async {
    Ruta ruta = _addRutaRepository.ruta;
    _addRutaRepository.updatePuntos(puntos);
    List<Marker> markers = [];
    Map<PolylineId, Polyline> polylines = {};

    ruta.puntos = puntos;

    if (ruta.puntos.length >= 2) {
      await api.getGoogleDirections();
      ruta = api.getRuta();

      // Defining an ID
      PolylineId id = const PolylineId('ruta');
      // Initializing Polyline
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: api.decodeEncodedPolyline(),
        width: 3,
      );

      // Adding the polyline to the map
      polylines = {};
      polylines[id] = polyline;
    }

    for (RutaPunto p in ruta.puntos) {
      log(p.punto.id.toString());
      log(p.punto.direccion);
      log(p.punto.latitud.toString());
      log(p.punto.longitud.toString());
      log(p.googleDistance?.text ?? "null");
      log(p.googleDuration?.text ?? "null");
      markers.add(Marker(
        markerId: MarkerId(p.punto.id.toString()),
        position: LatLng(p.punto.latitud, p.punto.longitud),
        icon: ImageStore.markerIcon,
      ));
    }

    emit(AddRutaReadyState(polylines: polylines, markers: markers, ruta: ruta));
  }
}
