// ignore_for_file: depend_on_referenced_packages
// Investigar como hacer para que no de un warning por dependencias
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

part 'listado_event.dart';
part 'listado_state.dart';

final getIt = GetIt.instance;

class ListadoPuntosRecoleccionBloc
    extends Bloc<ListadoPuntosRecoleccionEvent, ListadoPuntosRecoleccionState> {
  final PuntosRecoleccionRepository _puntoRecoleccionRespository = getIt();

  ListadoPuntosRecoleccionBloc()
      : super(ListadoInitialPuntosRecoleccionState()) {
    on<LoadListadoPuntosRecoleccionEvent>((event, emit) async {
      await _getPuntos(event: event, emit: emit);
    });
  }

  Future<void> _getPuntos(
      {required ListadoPuntosRecoleccionEvent event,
      required Emitter<ListadoPuntosRecoleccionState> emit}) async {
    try {
      final puntos = await _puntoRecoleccionRespository.getList();
      emit(ListadoSuccessPuntosRecoleccionState(puntosRecoleccion: puntos));
    } catch (e) {
      emit(ListadoErrorPuntosRecoleccionState());
    }
  }
}
