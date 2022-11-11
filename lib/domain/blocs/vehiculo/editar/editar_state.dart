part of 'editar_bloc.dart';

abstract class EditarVehiculoState extends Equatable {
  const EditarVehiculoState();

  @override
  List<Object> get props => [];
}

class EditarVehiculoInitial extends EditarVehiculoState {
  const EditarVehiculoInitial();
}

class EditarVehiculoSuccess extends EditarVehiculoState {
  final Vehiculo vehiculo;
  final bool isEditing;

  const EditarVehiculoSuccess(
      {required this.vehiculo, required this.isEditing});
}

class EditarVehiculoError extends EditarVehiculoState {
  final String message;
  const EditarVehiculoError({required this.message});
}
