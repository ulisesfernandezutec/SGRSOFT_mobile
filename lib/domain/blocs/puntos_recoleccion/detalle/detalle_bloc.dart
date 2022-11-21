import 'dart:core';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';

part 'detalle_event.dart';
part 'detalle_state.dart';

final getIt = GetIt.instance;

class DetallePuntosRecoleccionBloc
    extends Bloc<DetallePuntosRecoleccionEvent, DetallePuntosRecoleccionState> {
  final PuntosRecoleccionRepository _puntoRecoleccionRespository = getIt();

  DetallePuntosRecoleccionBloc()
      : super(DetalleInitialPuntosRecoleccionState()) {
    on<GetDetallePuntosRecoleccionEvent>((event, emit) async {
      await _getPunto(event: event, emit: emit);
    });
  }

  Future<void> _getPunto(
      {required GetDetallePuntosRecoleccionEvent event,
      required Emitter<DetallePuntosRecoleccionState> emit}) async {
    try {
      final punto = await _puntoRecoleccionRespository.get(event.id);
      emit(DetalleSuccessPuntosRecoleccionState(puntoRecoleccion: punto));
    } catch (e) {
      emit(DetalleErrorPuntosRecoleccionState(message: e.toString()));
    }
  }
}
