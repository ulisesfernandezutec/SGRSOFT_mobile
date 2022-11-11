part of 'nuevo_bloc.dart';

abstract class NuevoRolState extends Equatable {
  const NuevoRolState();

  @override
  List<Object> get props => [];
}

class NuevoRolInitialState extends NuevoRolState {}

class NuevoRolLoadingState extends NuevoRolState {}

class NuevoRolSuccessState extends NuevoRolState {
  final Rol rol;

  const NuevoRolSuccessState({required this.rol});
}

class NuevoRolErrorState extends NuevoRolState {
  final String message;

  const NuevoRolErrorState({required this.message});
}
