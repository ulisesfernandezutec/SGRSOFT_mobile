// ignore: depend_on_referenced_packages
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/usuario.dart';
import 'package:sgrsoft/domain/models/usuario.dart';

part 'detalle_event.dart';
part 'detalle_state.dart';

GetIt getIt = GetIt.instance;

class DetalleUsuarioBloc
    extends Bloc<DetalleUsuarioEvent, DetalleUsuarioState> {
  final UsuarioRepository _usuarioRepository = getIt();

  DetalleUsuarioBloc() : super(DetalleUsuarioInitial()) {
    on<LoadDetalleUsuarioEvent>((event, emit) async {
      log('LoadDetalleUsuarioEvent: ${event.id}');
      Usuario usuario = await _usuarioRepository.get(event.id);
      emit(DetalleUsuarioLoaded(usuario));
    });

    on<ErrorDetalleUsuarioEvent>((event, emit) async {
      emit(DetalleUsuarioError(event.message));
    });
  }
}
