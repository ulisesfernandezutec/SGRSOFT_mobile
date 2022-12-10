part of 'listado_bloc.dart';

abstract class ListadoRutaEvent extends Equatable {
  const ListadoRutaEvent();

  @override
  List<Object> get props => [];
}

class LoadListadoRutaEvent extends ListadoRutaEvent {
  final String search;
  const LoadListadoRutaEvent({this.search = ''});
}

class FiltedListadoRutaEvent extends ListadoRutaEvent {
  final String search;
  const FiltedListadoRutaEvent({this.search = ''});
}
