part of 'nuevo_bloc.dart';

abstract class NuevoPuntoSalidaEvent extends Equatable {
  const NuevoPuntoSalidaEvent();

  @override
  List<Object> get props => [];
}

class NuevoPuntoSalidaEventSave extends NuevoPuntoSalidaEvent {
  @override
  List<Object> get props => [];
}

class NuevoPuntoSalidaEventToMapa extends NuevoPuntoSalidaEvent {
  final String direccion;
  final String descripcion;

  const NuevoPuntoSalidaEventToMapa(
      {required this.direccion, required this.descripcion});

  @override
  List<Object> get props => [direccion, descripcion];
}

class NuevoPuntoSalidaEventSelectPoint extends NuevoPuntoSalidaEvent {
  final PuntoSalida punto;
  final double latitud;
  final double longitud;

  const NuevoPuntoSalidaEventSelectPoint(
      {required this.punto, required this.latitud, required this.longitud});

  @override
  List<Object> get props => [punto, latitud, longitud];
}

class NuevoPuntoSalidaEventMapRefresh extends NuevoPuntoSalidaEvent {
  final PuntoSalida punto;
  final double latitud;
  final double longitud;

  const NuevoPuntoSalidaEventMapRefresh(
      {required this.punto, required this.latitud, required this.longitud});

  @override
  List<Object> get props => [punto, latitud, longitud];
}

class NuevoPuntoSalidaEventToData extends NuevoPuntoSalidaEvent {
  final PuntoSalida punto;

  const NuevoPuntoSalidaEventToData(this.punto);

  @override
  List<Object> get props => [punto];
}
