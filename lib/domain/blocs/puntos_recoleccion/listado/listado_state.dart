part of 'listado_bloc.dart';

abstract class ListadoPuntosRecoleccionState {
  SearchPuntosRecoleccionObject? search;
  List<TipoDeResiduo> tiposResiduo;
  List<PuntoRecoleccion> puntosRecoleccion;
  List<PuntoRecoleccionEstado> puntosRecoleccionEstado;
  ListadoPuntosRecoleccionState(
      {this.search,
      this.tiposResiduo = const [],
      this.puntosRecoleccion = const [],
      this.puntosRecoleccionEstado = const []});
}

class ListadoInitialPuntosRecoleccionState
    extends ListadoPuntosRecoleccionState {
  ListadoInitialPuntosRecoleccionState(
      {super.search,
      super.tiposResiduo,
      super.puntosRecoleccion,
      super.puntosRecoleccionEstado});
}

class ListadoSuccessPuntosRecoleccionState
    extends ListadoPuntosRecoleccionState {
  ListadoSuccessPuntosRecoleccionState(
      {super.search,
      super.tiposResiduo,
      super.puntosRecoleccion,
      super.puntosRecoleccionEstado});
}

// ListadoErrorPuntosRecoleccionState
class ListadoErrorPuntosRecoleccionState extends ListadoPuntosRecoleccionState {
  String error;
  ListadoErrorPuntosRecoleccionState(
      {super.search,
      super.tiposResiduo,
      super.puntosRecoleccion,
      super.puntosRecoleccionEstado,
      required this.error});
}

// ListadoLoadingPuntosRecoleccionState
class ListadoLoadingPuntosRecoleccionState
    extends ListadoPuntosRecoleccionState {
  ListadoLoadingPuntosRecoleccionState(
      {super.search,
      super.tiposResiduo,
      super.puntosRecoleccion,
      super.puntosRecoleccionEstado});
}
