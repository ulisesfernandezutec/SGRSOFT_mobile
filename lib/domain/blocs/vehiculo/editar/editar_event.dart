part of 'editar_bloc.dart';

abstract class EditarVehiculoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateVehiculoEvent extends EditarVehiculoEvent {
  final Vehiculo vehiculo;

  UpdateVehiculoEvent({required this.vehiculo});
}
