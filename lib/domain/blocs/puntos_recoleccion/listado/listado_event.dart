part of 'listado_bloc.dart';

@immutable
abstract class ListadoPuntosRecoleccionEvent {}

class LoadListadoPuntosRecoleccionEvent extends ListadoPuntosRecoleccionEvent {
  final String search;
  LoadListadoPuntosRecoleccionEvent({this.search = ''});
}

class FiltedListadoPuntosRecoleccionEvent
    extends ListadoPuntosRecoleccionEvent {
  final String search;
  FiltedListadoPuntosRecoleccionEvent({this.search = ''});
}
