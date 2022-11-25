part of 'nuevo_bloc.dart';

abstract class NuevoPuntoDisposicionFinalState extends Equatable {
  final PuntoDisposicionFinal puntoDisposicionFinal;
  final List<TipoDeResiduo> tiposDeResiduos;

  const NuevoPuntoDisposicionFinalState(
      {required this.tiposDeResiduos, required this.puntoDisposicionFinal});
  @override
  List<Object> get props => [puntoDisposicionFinal, tiposDeResiduos];
}

class NuevoPuntoDisposicionFinalInitial
    extends NuevoPuntoDisposicionFinalState {
  const NuevoPuntoDisposicionFinalInitial(
      {required super.puntoDisposicionFinal, required super.tiposDeResiduos});
}

class NuevoPuntoDisposicionFinalLoading
    extends NuevoPuntoDisposicionFinalState {
  const NuevoPuntoDisposicionFinalLoading(
      {required super.puntoDisposicionFinal, required super.tiposDeResiduos});
}

class NuevoPuntoDisposicionFinalDatos extends NuevoPuntoDisposicionFinalState {
  const NuevoPuntoDisposicionFinalDatos(
      {required super.tiposDeResiduos, required super.puntoDisposicionFinal});
}

class NuevoPuntoDisposicionFinalMapa extends NuevoPuntoDisposicionFinalState {
  const NuevoPuntoDisposicionFinalMapa(
      {required super.tiposDeResiduos, required super.puntoDisposicionFinal});
}

class NuevoPuntoDisposicionFinalSuccess
    extends NuevoPuntoDisposicionFinalState {
  const NuevoPuntoDisposicionFinalSuccess(
      {required super.tiposDeResiduos, required super.puntoDisposicionFinal});
}
