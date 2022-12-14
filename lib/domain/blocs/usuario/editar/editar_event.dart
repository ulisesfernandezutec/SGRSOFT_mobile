part of 'editar_bloc.dart';

abstract class EditarUsuarioEvent extends Equatable {
  const EditarUsuarioEvent();

  @override
  List<Object> get props => [];
}

class EditarUsuarioEventLoad extends EditarUsuarioEvent {
  final int id;
  const EditarUsuarioEventLoad(this.id);
}

class EditarUsuarioEventSave extends EditarUsuarioEvent {
  final Usuario usuario;

  const EditarUsuarioEventSave({required this.usuario});
}

class EditarUsuarioEventUpdate extends EditarUsuarioEvent {
  final Usuario usuario;
  final bool showPassword;

  const EditarUsuarioEventUpdate(
      {required this.usuario, required this.showPassword});
}

class EditarUsuarioEventError extends EditarUsuarioEvent {}
