part of 'editar_bloc.dart';

abstract class EditarPuntoDisposicionFinalState extends Equatable {
  const EditarPuntoDisposicionFinalState();

  @override
  List<Object> get props => [];
}

class EditarPuntoDisposicionFinalInitial
    extends EditarPuntoDisposicionFinalState {}

class EditarPuntoDisposicionFinalLoading
    extends EditarPuntoDisposicionFinalState {}

class EditarPuntoDisposicionFinalLoaded
    extends EditarPuntoDisposicionFinalState {}
