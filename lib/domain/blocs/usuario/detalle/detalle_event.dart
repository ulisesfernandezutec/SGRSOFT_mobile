part of 'detalle_bloc.dart';

abstract class DetalleUsuarioEvent extends Equatable {
  const DetalleUsuarioEvent();

  @override
  List<Object> get props => [];
}

class LoadDetalleUsuarioEvent extends DetalleUsuarioEvent {
  final int id;
  const LoadDetalleUsuarioEvent(this.id);
}

class ErrorDetalleUsuarioEvent extends DetalleUsuarioEvent {
  final String message;
  const ErrorDetalleUsuarioEvent(this.message);
}
