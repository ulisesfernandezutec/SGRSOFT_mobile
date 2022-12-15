part of 'nueva_bloc.dart';

abstract class NuevaRutaState extends Equatable {
  const NuevaRutaState();

  @override
  List<Object> get props => [];
}

class NuevaRutaInitial extends NuevaRutaState {}

class NuevaRutaLoading extends NuevaRutaState {}

class NuevaRutaSaved extends NuevaRutaState {}

class NuevaRutaSuccess extends NuevaRutaState {}

class NuevaRutaError extends NuevaRutaState {}

class NuevaRutaMapa extends NuevaRutaState {
  final Ruta ruta;
  // Puntos de Salida
  final List<PuntoSalida> puntosSalida;
  // Puntos de Dispocision Final
  final List<PuntoDisposicionFinal> puntosDisposicionFinal;
  // Vehiculos
  final List<Vehiculo> vehiculos;
  // Choferes
  final List<Usuario> choferes;
  // Administradores
  final List<Usuario> administradores;
  // Puntos
  final List<RutaPunto> puntos;

  const NuevaRutaMapa(
      {required this.ruta,
      required this.puntosSalida,
      required this.puntosDisposicionFinal,
      required this.vehiculos,
      required this.choferes,
      required this.administradores,
      required this.puntos});
}

class NuevaRutaDatos extends NuevaRutaState {
  final Ruta ruta;
  // Nombre
  final List<PuntoSalida> puntosSalida;
  // Puntos de Dispocision Final
  final List<PuntoDisposicionFinal> puntosDisposicionFinal;
  // Vehiculos
  final List<Vehiculo> vehiculos;
  // Choferes
  final List<Usuario> choferes;
  // Administradores
  final List<Usuario> administradores;
  // Puntos Mapa
  final List<PuntoMapa> puntos;
  // Puntos para dibujar Polylines
  final List<LatLng> polylines;

  const NuevaRutaDatos(
      {required this.ruta,
      required this.puntosSalida,
      required this.puntosDisposicionFinal,
      required this.vehiculos,
      required this.choferes,
      required this.administradores,
      required this.puntos,
      required this.polylines});
}
