part of 'listado_bloc.dart';

@immutable
abstract class ListadoPuntosRecoleccionEvent {}

class LoadListadoPuntosRecoleccionEvent extends ListadoPuntosRecoleccionEvent {
  LoadListadoPuntosRecoleccionEvent();
}

class FiltedListadoPuntosRecoleccionEvent
    extends ListadoPuntosRecoleccionEvent {
  final String? buscar;
  final String? estado;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final List<int>? tipos;
  FiltedListadoPuntosRecoleccionEvent(
      {this.buscar, this.estado, this.fechaInicio, this.fechaFin, this.tipos});
}
