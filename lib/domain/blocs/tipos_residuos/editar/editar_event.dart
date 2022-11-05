part of 'editar_bloc.dart';

abstract class EditarTipoDeResiduoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class updateEvent extends EditarTipoDeResiduoEvent {
  final TipoDeResiduo tipoResiduo;

  updateEvent({required this.tipoResiduo});
}
