part of 'listado_bloc.dart';

abstract class ListadoUsuarioEvent extends Equatable {
  const ListadoUsuarioEvent();

  @override
  List<Object> get props => [];
}

class ListadoUsuarioLoad extends ListadoUsuarioEvent {}

class ListadoUsuarioFilter extends ListadoUsuarioEvent {
  final String filter;

  const ListadoUsuarioFilter({required this.filter});
}
