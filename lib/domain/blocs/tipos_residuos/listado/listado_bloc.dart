// ignore_for_file: depend_on_referenced_packages
// Investigar como hacer para que no de un warning por dependencias
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:sgrsoft/data/repository/tipos_de_residuos.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';

part 'listado_event.dart';
part 'listado_state.dart';

final getIt = GetIt.instance;

class ListadoTipoDeResiduosBloc
    extends Bloc<ListadoTiposDeResiduosEvent, ListadoTiposDeResiduosState> {
  final TiposDeResiduosRepository _tiposDeResiduosRespository = getIt();

  ListadoTipoDeResiduosBloc() : super(ListadoInitialTiposDeResiduosState()) {
    on<LoadListadoTiposDeResiduosEvent>((event, emit) async {
      await _getTipos(event: event, emit: emit);
    });
  }

  Future<void> _getTipos(
      {required ListadoTiposDeResiduosEvent event,
      required Emitter<ListadoTiposDeResiduosState> emit}) async {
    try {
      final tipos = await _tiposDeResiduosRespository.getList();
      emit(ListadoSuccessTiposDeResiduosState(tiposDeResiduos: tipos));
    } catch (e) {
      emit(ListadoErrorTiposDeResiduosState());
    }
  }
}
