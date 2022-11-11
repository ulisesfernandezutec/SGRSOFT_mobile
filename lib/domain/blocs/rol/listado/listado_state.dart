part of 'listado_bloc.dart';

abstract class ListadoRolState {
  List<Rol> rol;

  ListadoRolState({required this.rol});
}

class ListadoInitialRolState extends ListadoRolState {
  ListadoInitialRolState() : super(rol: []);
}

class ListadoSuccessRolState extends ListadoRolState {
  ListadoSuccessRolState({required List<Rol> rol}) : super(rol: rol);
}

// ListadoErrorRolState
class ListadoErrorRolState extends ListadoRolState {
  ListadoErrorRolState() : super(rol: []);
}
