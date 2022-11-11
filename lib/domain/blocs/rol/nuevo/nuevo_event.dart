part of 'nuevo_bloc.dart';

abstract class NuevoRolEvent extends Equatable {
  const NuevoRolEvent();

  @override
  List<Object> get props => [];
}

class SaveNuevoRolEvent extends NuevoRolEvent {
  final Rol rol;

  const SaveNuevoRolEvent({required this.rol});
}
