part of 'nuevo_bloc.dart';

abstract class NuevoUsuarioEvent extends Equatable {
  const NuevoUsuarioEvent();

  @override
  List<Object> get props => [];
}

class NuevoUsuarioEventLoad extends NuevoUsuarioEvent {}

class NuevoUsuarioEventSave extends NuevoUsuarioEvent {
  final Usuario usuario;

  const NuevoUsuarioEventSave({required this.usuario});
}

class NuevoUsuarioEventError extends NuevoUsuarioEvent {}
