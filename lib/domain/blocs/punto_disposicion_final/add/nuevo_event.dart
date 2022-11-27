part of 'nuevo_bloc.dart';

abstract class NuevoPuntoDisposicionFinalEvent extends Equatable {
  const NuevoPuntoDisposicionFinalEvent();

  @override
  List<Object> get props => [];
}

class NuevoPuntoDisposicionFinalEventSave
    extends NuevoPuntoDisposicionFinalEvent {
  @override
  List<Object> get props => [];
}

class NuevoPuntoDisposicionFinalEventLoad
    extends NuevoPuntoDisposicionFinalEvent {
  @override
  List<Object> get props => [];
}

class NuevoPuntoDisposicionFinalEventToMapa
    extends NuevoPuntoDisposicionFinalEvent {
  final String nombre;
  final String direccion;
  final String descripcion;
  final List<TipoDeResiduo> selectedTiposResiduos;

  const NuevoPuntoDisposicionFinalEventToMapa(
      {required this.nombre,
      required this.direccion,
      required this.descripcion,
      required this.selectedTiposResiduos});

  @override
  List<Object> get props => [nombre, direccion, descripcion];
}

class NuevoPuntoDisposicionFinalEventSelectPoint
    extends NuevoPuntoDisposicionFinalEvent {
  final PuntoDisposicionFinal punto;
  final double latitud;
  final double longitud;

  const NuevoPuntoDisposicionFinalEventSelectPoint(
      {required this.punto, required this.latitud, required this.longitud});

  @override
  List<Object> get props => [punto, latitud, longitud];
}

class NuevoPuntoDisposicionFinalEventSelectTipos
    extends NuevoPuntoDisposicionFinalEvent {
  final List<int> puntosIds;

  const NuevoPuntoDisposicionFinalEventSelectTipos({required this.puntosIds});

  @override
  List<Object> get props => [puntosIds];
}

class NuevoPuntoDisposicionFinalEventMapRefresh
    extends NuevoPuntoDisposicionFinalEvent {
  final PuntoDisposicionFinal punto;
  final double latitud;
  final double longitud;

  const NuevoPuntoDisposicionFinalEventMapRefresh(
      {required this.punto, required this.latitud, required this.longitud});

  @override
  List<Object> get props => [punto, latitud, longitud];
}

class NuevoPuntoDisposicionFinalEventToData
    extends NuevoPuntoDisposicionFinalEvent {
  final PuntoDisposicionFinal punto;

  const NuevoPuntoDisposicionFinalEventToData(this.punto);

  @override
  List<Object> get props => [punto];
}
