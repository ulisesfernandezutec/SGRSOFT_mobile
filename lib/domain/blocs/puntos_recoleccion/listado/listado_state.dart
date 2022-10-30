part of 'listado_bloc.dart';

abstract class ListadoPuntosRecoleccionState {
  List<PuntoRecoleccion> puntosRecoleccion;

  ListadoPuntosRecoleccionState({required this.puntosRecoleccion});
}

class ListadoInitialPuntosRecoleccionState
    extends ListadoPuntosRecoleccionState {
  ListadoInitialPuntosRecoleccionState() : super(puntosRecoleccion: []);
}

class ListadoSuccessPuntosRecoleccionState
    extends ListadoPuntosRecoleccionState {
  ListadoSuccessPuntosRecoleccionState(
      {required List<PuntoRecoleccion> puntosRecoleccion})
      : super(puntosRecoleccion: puntosRecoleccion);
}

// ListadoErrorPuntosRecoleccionState
class ListadoErrorPuntosRecoleccionState extends ListadoPuntosRecoleccionState {
  ListadoErrorPuntosRecoleccionState() : super(puntosRecoleccion: []);
}
