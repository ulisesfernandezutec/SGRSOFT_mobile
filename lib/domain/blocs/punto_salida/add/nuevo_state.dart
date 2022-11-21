part of 'nuevo_bloc.dart';

abstract class NuevoPuntoSalidaState extends Equatable {
  const NuevoPuntoSalidaState();

  @override
  List<Object> get props => [];
}

class NuevoPuntoSalidaInitial extends NuevoPuntoSalidaState {}

class NuevoPuntoSalidaLoading extends NuevoPuntoSalidaState {}

class NuevoPuntoSalidaDatos extends NuevoPuntoSalidaState {
  final PuntoSalida puntoSalida;
  const NuevoPuntoSalidaDatos({required this.puntoSalida});
}

class NuevoPuntoSalidaMapa extends NuevoPuntoSalidaState {
  final PuntoSalida puntoSalida;
  const NuevoPuntoSalidaMapa({required this.puntoSalida});
}

class NuevoPuntoSalidaSuccess extends NuevoPuntoSalidaState {}
