part of 'editar_bloc.dart';

abstract class EditarRolState extends Equatable {
  const EditarRolState();

  @override
  List<Object> get props => [];
}

class EditarRolInitial extends EditarRolState {
  const EditarRolInitial();
}

class EditarRolSuccess extends EditarRolState {
  final Rol rol;
  final bool isEditing;

  const EditarRolSuccess({required this.rol, required this.isEditing});
}

class EditarRolError extends EditarRolState {
  final String message;
  const EditarRolError({required this.message});
}
