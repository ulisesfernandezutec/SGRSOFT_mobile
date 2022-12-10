part of 'nueva_bloc.dart';

abstract class NuevaRutaEvent extends Equatable {
  const NuevaRutaEvent();

  @override
  List<Object> get props => [];
}

class NuevaRutaEventInitialLoad extends NuevaRutaEvent {
  @override
  List<Object> get props => [];
}

class NuevaRutaEventChangePuntos extends NuevaRutaEvent {
  final int id;

  const NuevaRutaEventChangePuntos({required this.id});

  @override
  List<Object> get props => [id];
}

class NuevaRutaEventChangeSalida extends NuevaRutaEvent {
  final int id;

  const NuevaRutaEventChangeSalida({required this.id});

  @override
  List<Object> get props => [id];
}

class NuevaRutaEventChangeFinal extends NuevaRutaEvent {
  final int id;

  const NuevaRutaEventChangeFinal({required this.id});

  @override
  List<Object> get props => [id];
}
