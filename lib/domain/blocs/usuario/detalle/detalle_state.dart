part of 'detalle_bloc.dart';

abstract class DetalleUsuarioState extends Equatable {
  const DetalleUsuarioState();

  @override
  List<Object> get props => [];
}

class DetalleUsuarioInitial extends DetalleUsuarioState {}

class DetalleUsuarioLoaded extends DetalleUsuarioState {
  final Usuario usuario;
  const DetalleUsuarioLoaded(this.usuario);
}

class DetalleUsuarioError extends DetalleUsuarioState {
  final String error;
  const DetalleUsuarioError(this.error);
}
