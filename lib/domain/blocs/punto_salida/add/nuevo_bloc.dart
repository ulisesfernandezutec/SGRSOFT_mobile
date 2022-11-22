// ignore: depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/data/api/api_google_geocode.dart';
import 'package:sgrsoft/data/repository/punto_salida_repository_imp.dart';
import 'package:sgrsoft/device/dev_geolocator.dart';
import 'package:sgrsoft/domain/models/punto_salida.dart';

part 'nuevo_event.dart';
part 'nuevo_state.dart';

final getIt = GetIt.instance;

class NuevoPuntoSalidaBloc
    extends Bloc<NuevoPuntoSalidaEvent, NuevoPuntoSalidaState> {
  final PuntoSalidaRepository _puntoSalidaRespository = getIt();
  late PuntoSalida puntoSalida;

  NuevoPuntoSalidaBloc() : super(NuevoPuntoSalidaInitial()) {
    on<NuevoPuntoSalidaEventSave>((event, emit) {
      emit(NuevoPuntoSalidaLoading());
      _puntoSalidaRespository.add(puntoSalida);
      emit(NuevoPuntoSalidaSuccess());
    });
    on<NuevoPuntoSalidaEventToMapa>((event, emit) async {
      emit(NuevoPuntoSalidaLoading());
      await _toMapa(
          emit: emit,
          nombre: event.nombre,
          direccion: event.direccion,
          descripcion: event.descripcion);
    });
    on<NuevoPuntoSalidaEventToData>((event, emit) async {
      emit(NuevoPuntoSalidaDatos(puntoSalida: event.punto));
    });
    on<NuevoPuntoSalidaEventSelectPoint>((event, emit) async {
      puntoSalida = event.punto;
      if (kDebugMode) {
        print('puntoSalida: ${puntoSalida.toJson()}');
      }
      emit(NuevoPuntoSalidaMapa(
          puntoSalida: PuntoSalida(
              id: puntoSalida.id,
              nombre: puntoSalida.nombre,
              descripcion: puntoSalida.descripcion,
              direccion: puntoSalida.direccion,
              latitud: event.latitud,
              longitud: event.longitud)));
    });
  }

  Future<void> _toMapa(
      {required Emitter<NuevoPuntoSalidaState> emit,
      required String nombre,
      required String direccion,
      required String descripcion}) async {
    ApiGoogleGeoCode apiGoogleGeoCode = ApiGoogleGeoCode();
    LatLng? coordenadas =
        await apiGoogleGeoCode.getLatLngFromAddress(direccion);
    if (coordenadas == null) {
      try {
        final position = await determinePosition();
        coordenadas = LatLng(position.latitude, position.longitude);
      } catch (e) {
        coordenadas = const LatLng(0, 0);
        log(e.toString());
      }
    }
    puntoSalida = PuntoSalida(
        nombre: nombre,
        direccion: direccion,
        descripcion: descripcion,
        latitud: coordenadas.latitude,
        longitud: coordenadas.longitude,
        id: 0);

    emit(NuevoPuntoSalidaMapa(puntoSalida: puntoSalida));
  }
}
