// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/usuario.dart';
import 'package:sgrsoft/domain/models/usuario.dart';

part 'listado_event.dart';
part 'listado_state.dart';

GetIt getIt = GetIt.instance;

class ListadoUsuarioBloc
    extends Bloc<ListadoUsuarioEvent, ListadoUsuarioState> {
  final UsuarioRepository _usuarioRepository = getIt();

  ListadoUsuarioBloc() : super(ListadoUsuarioInitial()) {
    on<ListadoUsuarioLoad>((event, emit) async {
      emit(ListadoUsuarioLoading());
      List<Usuario> usuarios = await _usuarioRepository.getList();
      emit(ListadoUsuarioSuccess(usuarios: usuarios));
    });
    on<ListadoUsuarioFilter>((event, emit) async {
      List<Usuario> usuarios = await _usuarioRepository.getList();
      if (event.filter.isEmpty) {
        emit(ListadoUsuarioSuccess(usuarios: usuarios));
        return;
      } else {
        usuarios = usuarios.where((element) {
          return element.nombre!
                  .toLowerCase()
                  .contains(event.filter.toLowerCase()) ||
              element.apellido!
                  .toLowerCase()
                  .contains(event.filter.toLowerCase());
        }).toList();
        emit(ListadoUsuarioSuccess(usuarios: usuarios));
      }
    });
  }
}
