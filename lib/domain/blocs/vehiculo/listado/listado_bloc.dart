// ignore_for_file: depend_on_referenced_packages
// Investigar como hacer para que no de un warning por dependencias
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:sgrsoft/data/repository/vehiculo.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';

part 'listado_event.dart';
part 'listado_state.dart';

final getIt = GetIt.instance;

class ListadoVehiculoBloc
    extends Bloc<ListadoVehiculoEvent, ListadoVehiculoState> {
  final VehiculoRepository _vehiculoRespository = getIt();

  ListadoVehiculoBloc() : super(ListadoInitialVehiculoState()) {
    on<LoadListadoVehiculoEvent>((event, emit) async {
      await _getTipos(event: event, emit: emit);
    });
  }

  Future<void> _getTipos(
      {required ListadoVehiculoEvent event,
      required Emitter<ListadoVehiculoState> emit}) async {
    try {
      final tipos = await _vehiculoRespository.getList();
      emit(ListadoSuccessVehiculoState(vehiculo: tipos));
    } catch (e) {
      emit(ListadoErrorVehiculoState());
    }
  }
}
