// ignore: depend_on_referenced_packages
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/usuario.dart';
import 'package:sgrsoft/domain/models/usuario.dart';

part 'nuevo_event.dart';
part 'nuevo_state.dart';

GetIt getIt = GetIt.instance;

class NuevoUsuarioBloc extends Bloc<NuevoUsuarioEvent, NuevoUsuarioState> {
  final UsuarioRepository _usuarioRepository = getIt();

  NuevoUsuarioBloc() : super(NuevoUsuarioInitial()) {
    on<NuevoUsuarioEventLoad>((event, emit) {
      emit(NuevoUsuarioInitial());
    });
    on<NuevoUsuarioEventSave>((event, emit) async {
      log("NuevoUsuarioEventSave: ${event.usuario.toString()}");
      await _usuarioRepository.add(event.usuario);
      await _usuarioRepository.getList();
      emit(NuevoUsuarioSuccess(usuario: event.usuario));
    });
  }
}
