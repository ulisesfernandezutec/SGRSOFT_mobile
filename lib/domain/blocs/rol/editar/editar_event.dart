part of 'editar_bloc.dart';

abstract class EditarRolEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateRolEvent extends EditarRolEvent {
  final Rol rol;

  UpdateRolEvent({required this.rol});
}
