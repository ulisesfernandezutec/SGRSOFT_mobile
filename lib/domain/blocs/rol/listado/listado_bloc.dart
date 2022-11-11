// ignore_for_file: depend_on_referenced_packages
// Investigar como hacer para que no de un warning por dependencias
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:sgrsoft/data/repository/rol.dart';
import 'package:sgrsoft/domain/models/rol.dart';

part 'listado_event.dart';
part 'listado_state.dart';

final getIt = GetIt.instance;

class ListadoRolBloc extends Bloc<ListadoRolEvent, ListadoRolState> {
  final RolRepository _rolRespository = getIt();

  ListadoRolBloc() : super(ListadoInitialRolState()) {
    on<LoadListadoRolEvent>((event, emit) async {
      await _getTipos(event: event, emit: emit);
    });
  }

  Future<void> _getTipos(
      {required ListadoRolEvent event,
      required Emitter<ListadoRolState> emit}) async {
    try {
      final tipos = await _rolRespository.getList();
      emit(ListadoSuccessRolState(rol: tipos));
    } catch (e) {
      emit(ListadoErrorRolState());
    }
  }
}
