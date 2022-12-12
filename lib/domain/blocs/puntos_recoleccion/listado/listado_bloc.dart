// ignore_for_file: depend_on_referenced_packages
// Investigar como hacer para que no de un warning por dependencias
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:sgrsoft/data/repository/tipos_residuos.dart';
import 'package:sgrsoft/data/streams/puntos_recoleccion_stream.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion_estado.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';
import 'package:sgrsoft/domain/models/utils/search_puntos_recoleccion.dart';

part 'listado_event.dart';
part 'listado_state.dart';

final getIt = GetIt.instance;

class ListadoPuntosRecoleccionBloc
    extends Bloc<ListadoPuntosRecoleccionEvent, ListadoPuntosRecoleccionState> {
  final StreamListadoPuntosRecoleccion _streamListadoPuntosRecoleccion =
      getIt();

  SearchPuntosRecoleccionObject objSearch = SearchPuntosRecoleccionObject();

  List<PuntoRecoleccion> _filtered = <PuntoRecoleccion>[];
  List<PuntoRecoleccion> _puntos = <PuntoRecoleccion>[];
  final TiposDeResiduosRepository _tiposDeResiduosRepository =
      getIt<TiposDeResiduosRepository>();

  ListadoPuntosRecoleccionBloc()
      : super(ListadoInitialPuntosRecoleccionState()) {
    on<LoadListadoPuntosRecoleccionEvent>((event, emit) async {
      // _streamListadoPuntosRecoleccion.refresh();
      await _getPuntos(event: event, emit: emit);
    });
    on<FiltedListadoPuntosRecoleccionEvent>((event, emit) async {
      await _filterPuntos(
          event: event, emit: emit, search: objSearch, puntos: _puntos);
    });
  }

  static get search => null;

  Future<void> _getPuntos(
      {required ListadoPuntosRecoleccionEvent event,
      required Emitter<ListadoPuntosRecoleccionState> emit}) async {
    List<TipoDeResiduo> tipos = await _tiposDeResiduosRepository.getList();
    if (_streamListadoPuntosRecoleccion.firstLoad!) {
      emit(ListadoLoadingPuntosRecoleccionState());
    } else {
      _filtered = searchFilter(
          _streamListadoPuntosRecoleccion.puntosRecoleccion, objSearch);
      emit(ListadoSuccessPuntosRecoleccionState(
          puntosRecoleccion: _filtered,
          search: objSearch,
          tiposResiduo: tipos));
    }

    await emit.forEach(_streamListadoPuntosRecoleccion.stream,
        onData: (List<PuntoRecoleccion> puntos) {
      _puntos = puntos;
      // log('_getPuntos 2');
      _filtered = searchFilter(puntos, objSearch);

      return ListadoSuccessPuntosRecoleccionState(
          puntosRecoleccion: _filtered, search: objSearch, tiposResiduo: tipos);
    });
    // .catchError((error) {
    //   log('_getPuntos $error');
    //   emit(ListadoErrorPuntosRecoleccionState(
    //       error: "Error al cargar los puntos de recolección"));
    // }
    // );

    // _streamListadoPuntosRecoleccion.stream.listen((event) async {
    //   if (event != null) {
    //     _puntos = event;
    //     _filtered = searchFilter(event, objSearch);
    //     emit(ListadoSuccessPuntosRecoleccionState(
    //         puntosRecoleccion: _filtered,
    //         search: objSearch,
    //         tiposResiduo: tipos));
    //   }
    // }
    // );

    // await emit.forEach(_streamListadoPuntosRecoleccion.stream,
    //     onData: (List<PuntoRecoleccion> puntos) {
    //   _puntos = puntos;
    //   _filtered = searchFilter(puntos, objSearch);

    //   return (ListadoSuccessPuntosRecoleccionState(
    //       puntosRecoleccion: _filtered, search: objSearch));
    // }).catchError((error) => emit(ListadoErrorPuntosRecoleccionState(
    //     error: "Error al cargar los puntos de recolección")));
  }

  Future<void> _filterPuntos(
      {required FiltedListadoPuntosRecoleccionEvent event,
      required Emitter<ListadoPuntosRecoleccionState> emit,
      required SearchPuntosRecoleccionObject search,
      required List<PuntoRecoleccion> puntos}) async {
    List<TipoDeResiduo> tipos = await _tiposDeResiduosRepository.getList();

    bool onlyBuscar = true;
    if (event.estado != null && event.estado != 'Todos') {
      objSearch.estado = event.estado;
      onlyBuscar = false;
    }
    if (event.buscar != null) {
      objSearch.buscar = event.buscar;
    }
    if (event.tipos != null) {
      objSearch.tipos =
          tipos.where((element) => event.tipos!.contains(element.id)).toList();
      onlyBuscar = false;
    }
    if (event.fechaFin != null) {
      objSearch.fechaFin = event.fechaFin;
      onlyBuscar = false;
    }
    if (event.fechaInicio != null) {
      objSearch.fechaInicio = event.fechaInicio;
      onlyBuscar = false;
    }

    if (!onlyBuscar) {
      emit(ListadoLoadingPuntosRecoleccionState());
      await _streamListadoPuntosRecoleccion.setFilter(objSearch);
    } else {
      puntos = searchFilter(puntos, objSearch);
    }

    emit(ListadoSuccessPuntosRecoleccionState(
      puntosRecoleccion: puntos,
      tiposResiduo: tipos,
      search: objSearch,
    ));
  }

  List<PuntoRecoleccion> searchFilter(
      List<PuntoRecoleccion> puntos, SearchPuntosRecoleccionObject search) {
    if (search.buscar != '' && search.buscar != null) {
      return puntos.where((element) {
        return element.direccion
                .toLowerCase()
                .contains(search.buscar!.toLowerCase()) ||
            element.descripcion
                .toLowerCase()
                .contains(search.buscar!.toLowerCase()) ||
            element.tipo.nombre
                .toLowerCase()
                .contains(search.buscar!.toLowerCase());
      }).toList();
    } else {
      return puntos;
    }
  }
}
