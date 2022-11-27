part of 'nuevo_bloc.dart';

abstract class NuevoPuntoRecoleccionState extends Equatable {
  final PuntoRecoleccion puntoRecoleccion;
  final List<TipoDeResiduo> tiposDeResiduos;

  const NuevoPuntoRecoleccionState(
      {required this.tiposDeResiduos, required this.puntoRecoleccion});
  @override
  List<Object> get props => [puntoRecoleccion, tiposDeResiduos];
}

class NuevoPuntoRecoleccionInitial extends NuevoPuntoRecoleccionState {
  const NuevoPuntoRecoleccionInitial(
      {required super.puntoRecoleccion, required super.tiposDeResiduos});
}

class NuevoPuntoRecoleccionLoading extends NuevoPuntoRecoleccionState {
  const NuevoPuntoRecoleccionLoading(
      {required super.puntoRecoleccion, required super.tiposDeResiduos});
}

class NuevoPuntoRecoleccionDatos extends NuevoPuntoRecoleccionState {
  const NuevoPuntoRecoleccionDatos(
      {required super.tiposDeResiduos, required super.puntoRecoleccion});
}

class NuevoPuntoRecoleccionMapa extends NuevoPuntoRecoleccionState {
  const NuevoPuntoRecoleccionMapa(
      {required super.tiposDeResiduos, required super.puntoRecoleccion});
}

class NuevoPuntoRecoleccionSuccess extends NuevoPuntoRecoleccionState {
  const NuevoPuntoRecoleccionSuccess(
      {required super.tiposDeResiduos, required super.puntoRecoleccion});
}
