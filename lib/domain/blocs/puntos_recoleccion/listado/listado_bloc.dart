// ignore_for_file: depend_on_referenced_packages
// Investigar como hacer para que no de un warning por dependencias
import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:sgrsoft/data/streams/puntos_recoleccion/listado.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

part 'listado_event.dart';
part 'listado_state.dart';

final getIt = GetIt.instance;

class ListadoPuntosRecoleccionBloc
    extends Bloc<ListadoPuntosRecoleccionEvent, ListadoPuntosRecoleccionState> {
  final StreamListadoPuntosRecoleccion _streamListadoPuntosRecoleccion =
      getIt();

  String _search = '';
  get getSearch => _search;
  List<PuntoRecoleccion> _filtered = <PuntoRecoleccion>[];
  List<PuntoRecoleccion> _puntos = <PuntoRecoleccion>[];

  ListadoPuntosRecoleccionBloc()
      : super(ListadoInitialPuntosRecoleccionState()) {
    on<LoadListadoPuntosRecoleccionEvent>((event, emit) async {
      _streamListadoPuntosRecoleccion.timerStart();
      if (event.search.isNotEmpty) {
        _streamListadoPuntosRecoleccion.refresh();
      }
      await _getPuntos(event: event, emit: emit);
    });
    on<FiltedListadoPuntosRecoleccionEvent>((event, emit) async {
      // List<PuntoRecoleccion> puntos = _streamListadoPuntosRecoleccion.stream;
      log('FiltedListadoPuntosRecoleccionEvent');
      _search = event.search;
      await _filterPuntos(
          event: event, emit: emit, search: event.search, puntos: _puntos);
    });
  }

  Future<void> _getPuntos(
      {required ListadoPuntosRecoleccionEvent event,
      required Emitter<ListadoPuntosRecoleccionState> emit}) async {
    // log('_getPuntos 1');
    await emit.forEach(_streamListadoPuntosRecoleccion.stream,
        onData: (List<PuntoRecoleccion> puntos) {
      _puntos = puntos;
      // log('_getPuntos 2');
      _filtered = searchFilter(puntos, _search);

      return ListadoSuccessPuntosRecoleccionState(
          puntosRecoleccion: _filtered, search: _search);
    }).catchError((error) => emit(ListadoErrorPuntosRecoleccionState()));
  }

  Future<void> _filterPuntos(
      {required FiltedListadoPuntosRecoleccionEvent event,
      required Emitter<ListadoPuntosRecoleccionState> emit,
      required String search,
      required List<PuntoRecoleccion> puntos}) async {
    _search = search;
    _filtered = searchFilter(puntos, search);
    // log('_filterPuntos: $search');
    emit(ListadoSuccessPuntosRecoleccionState(
        puntosRecoleccion: _filtered, search: search));
  }

  List<PuntoRecoleccion> searchFilter(
      List<PuntoRecoleccion> puntos, String search) {
    // log('searchFilter: $search');

    if (search.isNotEmpty) {
      // log('search not empy: $search');
      return puntos.where((element) {
        return element.direccion.toLowerCase().contains(search.toLowerCase()) ||
            element.descripcion.toLowerCase().contains(search.toLowerCase()) ||
            element.tipo.nombre.toLowerCase().contains(search.toLowerCase());
      }).toList();
    } else {
      // log('search empy: $search');
      return puntos;
    }
  }
}
