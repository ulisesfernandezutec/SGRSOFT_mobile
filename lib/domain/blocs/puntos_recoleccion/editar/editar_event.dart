part of 'editar_bloc.dart';

abstract class EditarPuntosRecoleccionEvent extends Equatable {
  const EditarPuntosRecoleccionEvent();

  @override
  List<Object> get props => [];
}

class LoadEditarPuntosRecoleccionEvent extends EditarPuntosRecoleccionEvent {}

class SaveEditarPuntosRecoleccionEvent extends EditarPuntosRecoleccionEvent {
  final PuntoRecoleccion puntoRecoleccion;

  const SaveEditarPuntosRecoleccionEvent({required this.puntoRecoleccion});
}
