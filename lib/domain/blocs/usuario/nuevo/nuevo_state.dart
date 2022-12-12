part of 'nuevo_bloc.dart';

abstract class NuevoUsuarioState extends Equatable {
  const NuevoUsuarioState();

  @override
  List<Object> get props => [];
}

class NuevoUsuarioInitial extends NuevoUsuarioState {}

class NuevoUsuarioLoading extends NuevoUsuarioState {}

class NuevoUsuarioSuccess extends NuevoUsuarioState {
  final Usuario usuario;

  const NuevoUsuarioSuccess({required this.usuario});
}

class NuevoUsuarioError extends NuevoUsuarioState {}
