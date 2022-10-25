part of 'detalle_bloc.dart';

abstract class DetallePuntosRecoleccionState {}

class DetalleInitialPuntosRecoleccionState
    extends DetallePuntosRecoleccionState {
  DetalleInitialPuntosRecoleccionState();
}

class DetalleSuccessPuntosRecoleccionState
    extends DetallePuntosRecoleccionState {
  PuntoRecoleccion puntoRecoleccion;
  DetalleSuccessPuntosRecoleccionState({required this.puntoRecoleccion});
}

class DetalleErrorPuntosRecoleccionState extends DetallePuntosRecoleccionState {
  String message;
  DetalleErrorPuntosRecoleccionState({required this.message});
}
