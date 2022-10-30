part of 'nuevo_bloc.dart';

abstract class NuevoTipoDeResiduoEvent extends Equatable {
  const NuevoTipoDeResiduoEvent();

  @override
  List<Object> get props => [];
}

class SaveNuevoTipoDeResiduoEvent extends NuevoTipoDeResiduoEvent {
  final TipoDeResiduo tipoDeResiduo;

  const SaveNuevoTipoDeResiduoEvent({required this.tipoDeResiduo});
}
