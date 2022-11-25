part of 'nuevo_bloc.dart';

abstract class NuevoPuntoDisposicionFinalState extends Equatable {
  const NuevoPuntoDisposicionFinalState();

  @override
  List<Object> get props => [];
}

class NuevoPuntoDisposicionFinalInitial
    extends NuevoPuntoDisposicionFinalState {}

class NuevoPuntoDisposicionFinalLoading
    extends NuevoPuntoDisposicionFinalState {}

class NuevoPuntoDisposicionFinalDatos extends NuevoPuntoDisposicionFinalState {
  final PuntoDisposicionFinal puntoDisposicionFinal;
  final List<TipoDeResiduo> tiposResiduos;
  const NuevoPuntoDisposicionFinalDatos(
      {required this.puntoDisposicionFinal, required this.tiposResiduos});
}

class NuevoPuntoDisposicionFinalMapa extends NuevoPuntoDisposicionFinalState {
  final PuntoDisposicionFinal puntoDisposicionFinal;
  const NuevoPuntoDisposicionFinalMapa({required this.puntoDisposicionFinal});
}

class NuevoPuntoDisposicionFinalSuccess
    extends NuevoPuntoDisposicionFinalState {}
