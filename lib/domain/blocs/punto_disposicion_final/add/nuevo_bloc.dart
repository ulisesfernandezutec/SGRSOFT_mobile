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

  List<TipoDeResiduo> tiposDeResiduos = [];

  NuevoPuntoDisposicionFinalBloc()
      : super(NuevoPuntoDisposicionFinalInitial(
            tiposDeResiduos: const [],
            puntoDisposicionFinal: PuntoDisposicionFinal(
                id: 0,
                nombre: '',
                latitud: 0,
                longitud: 0,
                direccion: '',
                descripcion: '',
                tipos: const []))) {
    on<NuevoPuntoDisposicionFinalEventSave>((event, emit) {
      emit(NuevoPuntoDisposicionFinalLoading(
          tiposDeResiduos: tiposDeResiduos,
          puntoDisposicionFinal: puntoDisposicionFinal));
      _puntoDisposicionFinalRespository.add(puntoDisposicionFinal);
      emit(NuevoPuntoDisposicionFinalSuccess(
          tiposDeResiduos: tiposDeResiduos,
          puntoDisposicionFinal: puntoDisposicionFinal));
    });
    on<NuevoPuntoDisposicionFinalEventToMapa>((event, emit) async {
      emit(NuevoPuntoDisposicionFinalLoading(
          tiposDeResiduos: tiposDeResiduos,
          puntoDisposicionFinal: puntoDisposicionFinal));
      await _toMapa(
          emit: emit,
          nombre: event.nombre,
          direccion: event.direccion,
          descripcion: event.descripcion,
          selectedTiposResiduos: event.selectedTiposResiduos);
    });
    on<NuevoPuntoDisposicionFinalEventToData>((event, emit) async {
      emit(NuevoPuntoDisposicionFinalDatos(
          puntoDisposicionFinal: event.punto,
          tiposDeResiduos: await _tiposDeResiduosRepository.getList()));
    });
    on<NuevoPuntoDisposicionFinalEventSelectPoint>((event, emit) async {
      puntoDisposicionFinal = PuntoDisposicionFinal(
          id: puntoDisposicionFinal.id,
          nombre: puntoDisposicionFinal.nombre,
          descripcion: puntoDisposicionFinal.descripcion,
          direccion: puntoDisposicionFinal.direccion,
          latitud: event.latitud,
          longitud: event.longitud,
          tipos: puntoDisposicionFinal.tipos);
      emit(NuevoPuntoDisposicionFinalMapa(
          puntoDisposicionFinal: puntoDisposicionFinal,
          tiposDeResiduos: const []));
    });
    on<NuevoPuntoDisposicionFinalEventLoad>((event, emit) async {
      emit(NuevoPuntoDisposicionFinalLoading(
          tiposDeResiduos: tiposDeResiduos,
          puntoDisposicionFinal: puntoDisposicionFinal));
      puntoDisposicionFinal = PuntoDisposicionFinal(
          id: 0,
          nombre: '',
          descripcion: '',
          direccion: '',
          latitud: 0,
          longitud: 0,
          tipos: const []);
      tiposDeResiduos = await _tiposDeResiduosRepository.getList();
      emit(NuevoPuntoDisposicionFinalDatos(
          puntoDisposicionFinal: puntoDisposicionFinal,
          tiposDeResiduos: tiposDeResiduos));
    });
    on<NuevoPuntoDisposicionFinalEventSelectTipos>((event, emit) async {
      tiposDeResiduos = await _tiposDeResiduosRepository.getList();
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
          puntoDisposicionFinal: punto, tiposDeResiduos: tiposDeResiduos));
    });
  }

  Future<void> _toMapa(
      {required Emitter<NuevoPuntoDisposicionFinalState> emit,
      required String nombre,
      required String direccion,
      required String descripcion,
      required List<TipoDeResiduo> selectedTiposResiduos}) async {
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
        tipos: selectedTiposResiduos,
        direccion: direccion,
        descripcion: descripcion,
        latitud: coordenadas.latitude,
        longitud: coordenadas.longitude,
        id: 0);
    puntoDisposicionFinal = punto;

    emit(NuevoPuntoDisposicionFinalMapa(
        puntoDisposicionFinal: puntoDisposicionFinal,
        tiposDeResiduos: tiposDeResiduos));
  }
}
