part of 'editar_bloc.dart';

abstract class EditarPuntosRecoleccionBlocState extends Equatable {
  const EditarPuntosRecoleccionBlocState();

  @override
  List<Object> get props => [];
}

class EditarInitialPuntosRecoleccionBlocState
    extends EditarPuntosRecoleccionBlocState {}

class EditarLoaderPuntosRecoleccionBlocState
    extends EditarPuntosRecoleccionBlocState {
  final List<TipoDeResiduo> tiposDeResiduos;
  final Position position;
  final PuntoRecoleccion puntoRecoleccion;

  const EditarLoaderPuntosRecoleccionBlocState(
      {required this.tiposDeResiduos,
      required this.position,
      required this.puntoRecoleccion});
}

class EditarSuccessPuntosRecoleccionBlocState
    extends EditarPuntosRecoleccionBlocState {
  const EditarSuccessPuntosRecoleccionBlocState();
}

class EditarErrorPuntosRecoleccionBlocState
    extends EditarPuntosRecoleccionBlocState {
  final String message;

  const EditarErrorPuntosRecoleccionBlocState({required this.message});
}
