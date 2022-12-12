part of 'listado_bloc.dart';

abstract class ListadoUsuarioState extends Equatable {
  const ListadoUsuarioState();

  @override
  List<Object> get props => [];
}

class ListadoUsuarioInitial extends ListadoUsuarioState {}

class ListadoUsuarioLoading extends ListadoUsuarioState {}

class ListadoUsuarioSuccess extends ListadoUsuarioState {
  final List<Usuario> usuarios;

  const ListadoUsuarioSuccess({required this.usuarios});
}

class ListadoUsuarioError extends ListadoUsuarioState {}
