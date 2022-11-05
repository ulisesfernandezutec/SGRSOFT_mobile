part of 'listado_bloc.dart';

abstract class ListadoPuntosRecoleccionState {
  List<PuntoRecoleccion> puntosRecoleccion;
  String search;

  ListadoPuntosRecoleccionState(
      {this.puntosRecoleccion = const <PuntoRecoleccion>[], this.search = ''});
}

class ListadoInitialPuntosRecoleccionState
    extends ListadoPuntosRecoleccionState {
  ListadoInitialPuntosRecoleccionState();
}

class ListadoSuccessPuntosRecoleccionState
    extends ListadoPuntosRecoleccionState {
  ListadoSuccessPuntosRecoleccionState(
      {puntosRecoleccion = const <PuntoRecoleccion>[], search = ''})
      : super(puntosRecoleccion: puntosRecoleccion, search: search);
}

// ListadoErrorPuntosRecoleccionState
class ListadoErrorPuntosRecoleccionState extends ListadoPuntosRecoleccionState {
  ListadoErrorPuntosRecoleccionState(
      {puntosRecoleccion = const <PuntoRecoleccion>[], search = ''})
      : super(puntosRecoleccion: puntosRecoleccion, search: search);
}
