part of 'listado_bloc.dart';

abstract class ListadoPuntoSalidaState extends Equatable {
  const ListadoPuntoSalidaState();

  @override
  List<Object> get props => [];
}

class ListadoPuntoSalidaInitial extends ListadoPuntoSalidaState {}

class ListadoPuntoSalidaLoading extends ListadoPuntoSalidaState {}

class ListadoPuntoSalidaLoaded extends ListadoPuntoSalidaState {
  final List<PuntoSalida> puntos;

  const ListadoPuntoSalidaLoaded({required this.puntos});

  @override
  List<Object> get props => [puntos];
}
