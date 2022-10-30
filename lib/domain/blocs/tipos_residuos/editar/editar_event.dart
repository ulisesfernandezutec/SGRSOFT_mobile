part of 'editar_bloc.dart';

abstract class EditarTipoDeResiduoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateTipoDeResiduoEvent extends EditarTipoDeResiduoEvent {
  final TipoDeResiduo tipoResiduo;

  UpdateTipoDeResiduoEvent({required this.tipoResiduo});
}
