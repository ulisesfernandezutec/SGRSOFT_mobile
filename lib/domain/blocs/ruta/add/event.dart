part of 'bloc.dart';

abstract class AddRutaEvent extends Equatable {
  const AddRutaEvent();

  @override
  List<Object> get props => [];
}

class LoadAddRutaEvent extends AddRutaEvent {
  const LoadAddRutaEvent();
}

class AgregarPuntoAddRutaEvent extends AddRutaEvent {
  final PuntoRecoleccion puntoRecoleccion;
  const AgregarPuntoAddRutaEvent({required this.puntoRecoleccion});
}

class ActualizarAddRutaEvent extends AddRutaEvent {
  final List<RutaPunto> puntos;
  const ActualizarAddRutaEvent({required this.puntos});
}
