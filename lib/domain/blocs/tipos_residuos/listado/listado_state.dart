part of 'listado_bloc.dart';

abstract class ListadoTiposDeResiduosState {
  List<TipoDeResiduo> tiposDeResiduos;

  ListadoTiposDeResiduosState({required this.tiposDeResiduos});
}

class ListadoInitialTiposDeResiduosState extends ListadoTiposDeResiduosState {
  ListadoInitialTiposDeResiduosState() : super(tiposDeResiduos: []);
}

class ListadoSuccessTiposDeResiduosState extends ListadoTiposDeResiduosState {
  ListadoSuccessTiposDeResiduosState(
      {required List<TipoDeResiduo> tiposDeResiduos})
      : super(tiposDeResiduos: tiposDeResiduos);
}

// ListadoErrorTiposDeResiduosState
class ListadoErrorTiposDeResiduosState extends ListadoTiposDeResiduosState {
  ListadoErrorTiposDeResiduosState() : super(tiposDeResiduos: []);
}
