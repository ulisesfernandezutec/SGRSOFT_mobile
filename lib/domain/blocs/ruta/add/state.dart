part of 'bloc.dart';

abstract class AddRutaState extends Equatable {
  const AddRutaState();

  @override
  List<Object> get props => [];
}

class AddRutaInitialState extends AddRutaState {}

class AddRutaLoadState extends AddRutaState {
  const AddRutaLoadState();

  @override
  List<Object> get props => [];
}

class AddRutaReadyState extends AddRutaState {
  final Map<PolylineId, Polyline> polylines;
  final List<Marker> markers;
  final Ruta ruta;

  const AddRutaReadyState(
      //
      {required this.polylines,
      required this.markers,
      required this.ruta});

  @override
  List<Object> get props => [polylines, markers, ruta];
}
