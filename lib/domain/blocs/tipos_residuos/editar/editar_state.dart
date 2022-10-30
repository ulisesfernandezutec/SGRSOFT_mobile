part of 'editar_bloc.dart';

abstract class EditarTipoDeResiduoState extends Equatable {
  const EditarTipoDeResiduoState();

  @override
  List<Object> get props => [];
}

class EditarTipoDeResiduoInitial extends EditarTipoDeResiduoState {
  const EditarTipoDeResiduoInitial();
}

class EditarTipoDeResiduoSuccess extends EditarTipoDeResiduoState {
  final TipoDeResiduo tipoResiduo;
  final bool isEditing;

  const EditarTipoDeResiduoSuccess(
      {required this.tipoResiduo, required this.isEditing});
}

class EditarTipoDeResiduoError extends EditarTipoDeResiduoState {
  final String message;
  const EditarTipoDeResiduoError({required this.message});
}
