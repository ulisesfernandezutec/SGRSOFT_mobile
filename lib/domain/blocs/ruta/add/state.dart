part of 'bloc.dart';

abstract class AddRutaState extends Equatable {
  const AddRutaState();

  @override
  List<Object> get props => [];
}

class AddRutaInitialState extends AddRutaState {}

class AddRutaReadyState extends AddRutaState {
  final List<PuntoRecoleccion> puntosRecoleccion;
  final Set<Polyline> polylines;
  final Set<Marker> markers;

  const AddRutaReadyState(
      {required this.puntosRecoleccion,
      required this.polylines,
      required this.markers});
}
