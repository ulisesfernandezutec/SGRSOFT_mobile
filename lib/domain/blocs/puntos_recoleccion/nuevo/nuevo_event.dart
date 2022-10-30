part of 'nuevo_bloc.dart';

abstract class NuevoPuntosRecoleccionEvent extends Equatable {
  const NuevoPuntosRecoleccionEvent();

  @override
  List<Object> get props => [];
}

class LoadNuevoPuntosRecoleccionEvent extends NuevoPuntosRecoleccionEvent {}

class SaveNuevoPuntosRecoleccionEvent extends NuevoPuntosRecoleccionEvent {
  final String direccion;
  final double latitud;
  final double longitud;
  final String descripcion;
  final int idTipoDeResiduo;

  const SaveNuevoPuntosRecoleccionEvent(
      {required this.direccion,
      required this.latitud,
      required this.longitud,
      required this.descripcion,
      required this.idTipoDeResiduo});
}
