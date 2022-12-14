// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/usuario.dart';
import 'package:sgrsoft/domain/models/usuario.dart';

part 'editar_event.dart';
part 'editar_state.dart';

GetIt getIt = GetIt.instance;

class EditarUsuarioBloc extends Bloc<EditarUsuarioEvent, EditarUsuarioState> {
  final UsuarioRepository _usuarioRepository = getIt();

  EditarUsuarioBloc() : super(EditarUsuarioInitial()) {
    on<EditarUsuarioEventLoad>((event, emit) async {
      Usuario usuario = await _usuarioRepository.get(event.id);
      emit(EditarUsuarioSuccess(usuario: usuario, showPassword: false));
    });
    on<EditarUsuarioEventUpdate>((event, emit) async {
      emit(EditarUsuarioSuccess(
          usuario: event.usuario, showPassword: event.showPassword));
    });
    on<EditarUsuarioEventSave>((event, emit) async {
      emit(EditarUsuarioLoading());
      bool result = await _usuarioRepository.update(event.usuario);
      if (result) {
        await _usuarioRepository.getList();
        emit(EditarUsuarioSaved());
      } else {
        emit(const EditarUsuarioError(
            "Error desconocido intente nuevamente o ponganse en contacto con el administrador del sistema."));
      }
    });
  }
}
