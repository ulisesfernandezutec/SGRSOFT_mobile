part of 'editar_bloc.dart';

abstract class EditarUsuarioState extends Equatable {
  const EditarUsuarioState();

  @override
  List<Object> get props => [];
}

class EditarUsuarioInitial extends EditarUsuarioState {}

class EditarUsuarioLoading extends EditarUsuarioState {}

class EditarUsuarioSaved extends EditarUsuarioState {}

class EditarUsuarioSuccess extends EditarUsuarioState {
  final Usuario usuario;
  final bool showPassword;

  const EditarUsuarioSuccess(
      {required this.usuario, required this.showPassword});
}

class EditarUsuarioError extends EditarUsuarioState {
  final String error;
  const EditarUsuarioError(this.error);
}
