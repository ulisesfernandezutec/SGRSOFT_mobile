part of 'nuevo_bloc.dart';

abstract class NuevoPuntosRecoleccionBlocState extends Equatable {
  const NuevoPuntosRecoleccionBlocState();

  @override
  List<Object> get props => [];
}

class NuevoInitialPuntosRecoleccionBlocState
    extends NuevoPuntosRecoleccionBlocState {}

class NuevoLoaderPuntosRecoleccionBlocState
    extends NuevoPuntosRecoleccionBlocState {
  final List<TipoDeResiduo> tiposDeResiduos;
  final Position position;

  const NuevoLoaderPuntosRecoleccionBlocState(
      {required this.tiposDeResiduos, required this.position});
}

class NuevoSuccessPuntosRecoleccionBlocState
    extends NuevoPuntosRecoleccionBlocState {
  const NuevoSuccessPuntosRecoleccionBlocState();
}

class NuevoErrorPuntosRecoleccionBlocState
    extends NuevoPuntosRecoleccionBlocState {
  final String message;

  const NuevoErrorPuntosRecoleccionBlocState({required this.message});
}
