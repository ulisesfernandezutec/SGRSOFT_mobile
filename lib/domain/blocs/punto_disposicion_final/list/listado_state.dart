part of 'listado_bloc.dart';

abstract class ListadoPuntoDisposicionFinalState extends Equatable {
  const ListadoPuntoDisposicionFinalState();

  @override
  List<Object> get props => [];
}

class ListadoPuntoDisposicionFinalInitial
    extends ListadoPuntoDisposicionFinalState {}

class ListadoPuntoDisposicionFinalLoading
    extends ListadoPuntoDisposicionFinalState {}

class ListadoPuntoDisposicionFinalLoaded
    extends ListadoPuntoDisposicionFinalState {
  final List<PuntoDisposicionFinal> puntos;

  const ListadoPuntoDisposicionFinalLoaded({required this.puntos});

  @override
  List<Object> get props => [puntos];
}
