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
import 'package:sgrsoft/data/repository/punto_disposicion_final_repository_imp.dart';
import 'package:sgrsoft/data/repository/tipos_residuos.dart';
import 'package:sgrsoft/device/dev_geolocator.dart';
import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';

part 'nuevo_event.dart';
part 'nuevo_state.dart';

final getIt = GetIt.instance;

class NuevoPuntoDisposicionFinalBloc extends Bloc<
    NuevoPuntoDisposicionFinalEvent, NuevoPuntoDisposicionFinalState> {
  final PuntoDisposicionFinalRepository _puntoDisposicionFinalRespository =
      getIt();
  final TiposDeResiduosRepository _tiposDeResiduosRepository = getIt();

  PuntoDisposicionFinal puntoDisposicionFinal = PuntoDisposicionFinal(
      id: 0,
      nombre: '',
      latitud: 0,
      longitud: 0,
      direccion: '',
      descripcion: '',
      tipos: const []);

  NuevoPuntoDisposicionFinalBloc()
      : super(NuevoPuntoDisposicionFinalInitial()) {
    on<NuevoPuntoDisposicionFinalEventSave>((event, emit) {
      emit(NuevoPuntoDisposicionFinalLoading());
      _puntoDisposicionFinalRespository.add(puntoDisposicionFinal);
      emit(NuevoPuntoDisposicionFinalSuccess());
    });
    on<NuevoPuntoDisposicionFinalEventToMapa>((event, emit) async {
      emit(NuevoPuntoDisposicionFinalLoading());
      await _toMapa(
          emit: emit,
          nombre: event.nombre,
          direccion: event.direccion,
          descripcion: event.descripcion);
    });
    on<NuevoPuntoDisposicionFinalEventToData>((event, emit) async {
      emit(NuevoPuntoDisposicionFinalDatos(
          puntoDisposicionFinal: event.punto,
          tiposResiduos: await _tiposDeResiduosRepository.getList()));
    });
    on<NuevoPuntoDisposicionFinalEventSelectPoint>((event, emit) async {
      puntoDisposicionFinal = event.punto;
      if (kDebugMode) {
        print('puntoDisposicionFinal: ${puntoDisposicionFinal.toJson()}');
      }
      emit(NuevoPuntoDisposicionFinalMapa(
          puntoDisposicionFinal: PuntoDisposicionFinal(
              id: puntoDisposicionFinal.id,
              nombre: puntoDisposicionFinal.nombre,
              descripcion: puntoDisposicionFinal.descripcion,
              direccion: puntoDisposicionFinal.direccion,
              latitud: event.latitud,
              longitud: event.longitud,
              tipos: puntoDisposicionFinal.tipos)));
    });
    on<NuevoPuntoDisposicionFinalEventLoad>((event, emit) async {
      emit(NuevoPuntoDisposicionFinalLoading());
      puntoDisposicionFinal = PuntoDisposicionFinal(
          id: 0,
          nombre: '',
          descripcion: '',
          direccion: '',
          latitud: 0,
          longitud: 0,
          tipos: const []);
      emit(NuevoPuntoDisposicionFinalDatos(
          puntoDisposicionFinal: puntoDisposicionFinal,
          tiposResiduos: await _tiposDeResiduosRepository.getList()));
    });
    on<NuevoPuntoDisposicionFinalEventSelectTipos>((event, emit) async {
      List<TipoDeResiduo> tipos =
          await _tiposDeResiduosRepository.getListByIds(event.puntosIds);
      PuntoDisposicionFinal punto = PuntoDisposicionFinal(
          id: puntoDisposicionFinal.id,
          latitud: puntoDisposicionFinal.latitud,
          longitud: puntoDisposicionFinal.longitud,
          direccion: puntoDisposicionFinal.direccion,
          descripcion: puntoDisposicionFinal.descripcion,
          tipos: tipos,
          nombre: puntoDisposicionFinal.nombre);
      puntoDisposicionFinal = punto;
      emit(NuevoPuntoDisposicionFinalDatos(
          puntoDisposicionFinal: punto,
          tiposResiduos: await _tiposDeResiduosRepository.getList()));
    });
  }

  Future<void> _toMapa(
      {required Emitter<NuevoPuntoDisposicionFinalState> emit,
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
    PuntoDisposicionFinal punto = PuntoDisposicionFinal(
        nombre: nombre,
        tipos: puntoDisposicionFinal.tipos,
        direccion: direccion,
        descripcion: descripcion,
        latitud: coordenadas.latitude,
        longitud: coordenadas.longitude,
        id: 0);
    puntoDisposicionFinal = punto;

    emit(NuevoPuntoDisposicionFinalMapa(
        puntoDisposicionFinal: puntoDisposicionFinal));
  }
}
