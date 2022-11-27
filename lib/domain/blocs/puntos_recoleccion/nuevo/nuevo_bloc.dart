// ignore: depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/data/api/api_google_geocode.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/data/repository/tipos_residuos.dart';
import 'package:sgrsoft/data/streams/puntos_recoleccion/listado.dart';
import 'package:sgrsoft/device/dev_geolocator.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';

part 'nuevo_event.dart';
part 'nuevo_state.dart';

final getIt = GetIt.instance;

class NuevoPuntoRecoleccionBloc
    extends Bloc<NuevoPuntoRecoleccionEvent, NuevoPuntoRecoleccionState> {
  final PuntosRecoleccionRepository _puntoRecoleccionRespository = getIt();
  final TiposDeResiduosRepository _tiposDeResiduosRepository = getIt();

  PuntoRecoleccion puntoRecoleccion = PuntoRecoleccion(
      id: 0,
      latitud: 0,
      longitud: 0,
      direccion: '',
      descripcion: '',
      tipo: TipoDeResiduo(id: 0, nombre: ''));

  List<TipoDeResiduo> tiposDeResiduos = [];

  NuevoPuntoRecoleccionBloc()
      : super(NuevoPuntoRecoleccionInitial(
            tiposDeResiduos: const [],
            puntoRecoleccion: PuntoRecoleccion(
                id: 0,
                latitud: 0,
                longitud: 0,
                direccion: '',
                descripcion: '',
                tipo: TipoDeResiduo(id: 0, nombre: '')))) {
    on<NuevoPuntoRecoleccionEventSave>((event, emit) {
      emit(NuevoPuntoRecoleccionLoading(
          tiposDeResiduos: tiposDeResiduos,
          puntoRecoleccion: puntoRecoleccion));
      _puntoRecoleccionRespository.add(puntoRecoleccion);
      StreamListadoPuntosRecoleccion streamListadoPuntosRecoleccion = getIt();
      streamListadoPuntosRecoleccion.refresh();
      emit(NuevoPuntoRecoleccionSuccess(
          tiposDeResiduos: tiposDeResiduos,
          puntoRecoleccion: puntoRecoleccion));
    });
    on<NuevoPuntoRecoleccionEventToMapa>((event, emit) async {
      if (event.indexTipoDeResiduo != null) {
        emit(NuevoPuntoRecoleccionLoading(
            tiposDeResiduos: tiposDeResiduos,
            puntoRecoleccion: puntoRecoleccion));
        await _toMapa(
            emit: emit,
            direccion: event.direccion,
            descripcion: event.descripcion,
            indexTipoDeResiduo: event.indexTipoDeResiduo!);
      }
    });
    on<NuevoPuntoRecoleccionEventToData>((event, emit) async {
      emit(NuevoPuntoRecoleccionDatos(
          puntoRecoleccion: event.punto,
          tiposDeResiduos: await _tiposDeResiduosRepository.getList()));
    });
    on<NuevoPuntoRecoleccionEventSelectPoint>((event, emit) async {
      // puntoRecoleccion = event.punto;
      print(puntoRecoleccion.toJson().toString());
      print(event.punto.toJson().toString());
      print(event.latitud.toString());
      print(event.longitud.toString());
      puntoRecoleccion = PuntoRecoleccion(
          id: puntoRecoleccion.id,
          descripcion: puntoRecoleccion.descripcion,
          direccion: puntoRecoleccion.direccion,
          latitud: event.latitud,
          longitud: event.longitud,
          tipo: puntoRecoleccion.tipo);

      emit(NuevoPuntoRecoleccionMapa(
          puntoRecoleccion: puntoRecoleccion, tiposDeResiduos: const []));
    });
    on<NuevoPuntoRecoleccionEventLoad>((event, emit) async {
      emit(NuevoPuntoRecoleccionLoading(
          tiposDeResiduos: tiposDeResiduos,
          puntoRecoleccion: puntoRecoleccion));
      puntoRecoleccion = PuntoRecoleccion(
          id: 0,
          latitud: 0,
          longitud: 0,
          direccion: '',
          descripcion: '',
          tipo: TipoDeResiduo(id: 0, nombre: ''));
      tiposDeResiduos = await _tiposDeResiduosRepository.getList();
      emit(NuevoPuntoRecoleccionDatos(
          puntoRecoleccion: puntoRecoleccion,
          tiposDeResiduos: tiposDeResiduos));
    });
    on<NuevoPuntoRecoleccionEventSelectTipo>((event, emit) async {
      tiposDeResiduos = await _tiposDeResiduosRepository.getList();
      TipoDeResiduo tipo =
          await _tiposDeResiduosRepository.get(event.tipoResiduoId);
      PuntoRecoleccion punto = PuntoRecoleccion(
          id: puntoRecoleccion.id,
          latitud: puntoRecoleccion.latitud,
          longitud: puntoRecoleccion.longitud,
          direccion: puntoRecoleccion.direccion,
          descripcion: puntoRecoleccion.descripcion,
          tipo: tipo);
      puntoRecoleccion = punto;
      emit(NuevoPuntoRecoleccionDatos(
          puntoRecoleccion: punto, tiposDeResiduos: tiposDeResiduos));
    });
  }

  Future<void> _toMapa(
      {required Emitter<NuevoPuntoRecoleccionState> emit,
      required String direccion,
      required String descripcion,
      required int indexTipoDeResiduo}) async {
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

    TipoDeResiduo tipo = tiposDeResiduos[indexTipoDeResiduo - 1];
    PuntoRecoleccion punto = PuntoRecoleccion(
        tipo: tipo,
        direccion: direccion,
        descripcion: descripcion,
        latitud: coordenadas.latitude,
        longitud: coordenadas.longitude,
        id: 0);
    puntoRecoleccion = punto;

    emit(NuevoPuntoRecoleccionMapa(
        puntoRecoleccion: puntoRecoleccion, tiposDeResiduos: tiposDeResiduos));
  }
}
