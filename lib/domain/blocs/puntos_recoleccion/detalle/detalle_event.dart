part of 'detalle_bloc.dart';

abstract class DetallePuntosRecoleccionEvent {}

class GetDetallePuntosRecoleccionEvent extends DetallePuntosRecoleccionEvent {
  final int id;

  GetDetallePuntosRecoleccionEvent({required this.id});
}
