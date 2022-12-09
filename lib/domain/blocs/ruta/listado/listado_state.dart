part of 'listado_bloc.dart';

abstract class ListadoRutaState extends Equatable {
  const ListadoRutaState();

  @override
  List<Object> get props => [];
}

class ListadoRutaInitial extends ListadoRutaState {}

class ListadoRutaSuccess extends ListadoRutaState {
  final List<Ruta> rutas;
  final String search;

  const ListadoRutaSuccess({this.rutas = const <Ruta>[], this.search = ''});
}

class ListadoRutaError extends ListadoRutaState {
  final List<Ruta> rutas;
  final String search;

  const ListadoRutaError({this.rutas = const <Ruta>[], this.search = ''});
}
