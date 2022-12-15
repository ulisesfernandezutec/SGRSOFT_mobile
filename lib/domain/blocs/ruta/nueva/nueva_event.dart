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

class NuevaRutaEventSave extends NuevaRutaEvent {
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

class NuevaRutaEventChangeOptimizar extends NuevaRutaEvent {
  final bool optimizar;

  const NuevaRutaEventChangeOptimizar({required this.optimizar});

  @override
  List<Object> get props => [optimizar];
}

class NuevaRutaEventChangeChofer extends NuevaRutaEvent {
  final int id;

  const NuevaRutaEventChangeChofer({required this.id});

  @override
  List<Object> get props => [id];
}

class NuevaRutaEventChangeVehiculo extends NuevaRutaEvent {
  final int id;

  const NuevaRutaEventChangeVehiculo({required this.id});

  @override
  List<Object> get props => [id];
}

class NuevaRutaEventChangeFecha extends NuevaRutaEvent {
  final DateTime fecha;

  const NuevaRutaEventChangeFecha({required this.fecha});

  @override
  List<Object> get props => [fecha];
}

class NuevaRutaEventChangeNombre extends NuevaRutaEvent {
  final String nombre;

  const NuevaRutaEventChangeNombre({required this.nombre});

  @override
  List<Object> get props => [nombre];
}
