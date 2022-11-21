part of 'editar_bloc.dart';

abstract class EditarPuntoSalidaState extends Equatable {
  const EditarPuntoSalidaState();

  @override
  List<Object> get props => [];
}

class EditarPuntoSalidaInitial extends EditarPuntoSalidaState {}

class EditarPuntoSalidaLoading extends EditarPuntoSalidaState {}

class EditarPuntoSalidaLoaded extends EditarPuntoSalidaState {}
