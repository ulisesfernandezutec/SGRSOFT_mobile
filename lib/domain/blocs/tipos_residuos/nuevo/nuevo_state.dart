part of 'nuevo_bloc.dart';

abstract class NuevoTipoDeResiduoState extends Equatable {
  const NuevoTipoDeResiduoState();

  @override
  List<Object> get props => [];
}

class NuevoTipoDeResiduoInitialState extends NuevoTipoDeResiduoState {}

class NuevoTipoDeResiduoLoadingState extends NuevoTipoDeResiduoState {}

class NuevoTipoDeResiduoSuccessState extends NuevoTipoDeResiduoState {
  final TipoDeResiduo tipoDeResiduo;

  const NuevoTipoDeResiduoSuccessState({required this.tipoDeResiduo});
}

class NuevoTipoDeResiduoErrorState extends NuevoTipoDeResiduoState {
  final String message;

  const NuevoTipoDeResiduoErrorState({required this.message});
}
