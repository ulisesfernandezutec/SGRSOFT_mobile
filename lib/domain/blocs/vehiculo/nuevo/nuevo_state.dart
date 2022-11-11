part of 'nuevo_bloc.dart';

abstract class NuevoVehiculoState extends Equatable {
  const NuevoVehiculoState();

  @override
  List<Object> get props => [];
}

class NuevoVehiculoInitialState extends NuevoVehiculoState {}

class NuevoVehiculoLoadingState extends NuevoVehiculoState {}

class NuevoVehiculoSuccessState extends NuevoVehiculoState {
  final Vehiculo vehiculo;

  const NuevoVehiculoSuccessState({required this.vehiculo});
}

class NuevoVehiculoErrorState extends NuevoVehiculoState {
  final String message;

  const NuevoVehiculoErrorState({required this.message});
}
