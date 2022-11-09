part of 'nuevo_bloc.dart';

abstract class NuevoVehiculoEvent extends Equatable {
  const NuevoVehiculoEvent();

  @override
  List<Object> get props => [];
}

class SaveNuevoVehiculoEvent extends NuevoVehiculoEvent {
  final Vehiculo vehiculo;

  const SaveNuevoVehiculoEvent({required this.vehiculo});
}
