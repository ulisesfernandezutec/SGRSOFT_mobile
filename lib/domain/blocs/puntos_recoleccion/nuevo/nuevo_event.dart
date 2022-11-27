part of 'nuevo_bloc.dart';

abstract class NuevoPuntoRecoleccionEvent extends Equatable {
  const NuevoPuntoRecoleccionEvent();

  @override
  List<Object> get props => [];
}

class NuevoPuntoRecoleccionEventSave extends NuevoPuntoRecoleccionEvent {
  @override
  List<Object> get props => [];
}

class NuevoPuntoRecoleccionEventLoad extends NuevoPuntoRecoleccionEvent {
  @override
  List<Object> get props => [];
}

class NuevoPuntoRecoleccionEventToMapa extends NuevoPuntoRecoleccionEvent {
  final String direccion;
  final String descripcion;
  final int? indexTipoDeResiduo;

  const NuevoPuntoRecoleccionEventToMapa(
      {required this.direccion,
      required this.descripcion,
      required this.indexTipoDeResiduo});

  @override
  List<Object> get props => [direccion, descripcion];
}

class NuevoPuntoRecoleccionEventSelectPoint extends NuevoPuntoRecoleccionEvent {
  final PuntoRecoleccion punto;
  final double latitud;
  final double longitud;

  const NuevoPuntoRecoleccionEventSelectPoint(
      {required this.punto, required this.latitud, required this.longitud});

  @override
  List<Object> get props => [punto, latitud, longitud];
}

class NuevoPuntoRecoleccionEventSelectTipo extends NuevoPuntoRecoleccionEvent {
  final int tipoResiduoId;

  const NuevoPuntoRecoleccionEventSelectTipo({required this.tipoResiduoId});

  @override
  List<Object> get props => [tipoResiduoId];
}

class NuevoPuntoRecoleccionEventMapRefresh extends NuevoPuntoRecoleccionEvent {
  final PuntoRecoleccion punto;
  final double latitud;
  final double longitud;

  const NuevoPuntoRecoleccionEventMapRefresh(
      {required this.punto, required this.latitud, required this.longitud});

  @override
  List<Object> get props => [punto, latitud, longitud];
}

class NuevoPuntoRecoleccionEventToData extends NuevoPuntoRecoleccionEvent {
  final PuntoRecoleccion punto;

  const NuevoPuntoRecoleccionEventToData(this.punto);

  @override
  List<Object> get props => [punto];
}
