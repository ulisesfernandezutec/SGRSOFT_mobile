// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/rol.dart';
import 'package:sgrsoft/domain/models/rol.dart';

part 'editar_event.dart';
part 'editar_state.dart';

final getIt = GetIt.instance;

class EditarRolBloc extends Bloc<EditarRolEvent, EditarRolState> {
  final RolRepository _rolRespository = getIt();

  EditarRolBloc() : super(const EditarRolInitial()) {
    on<UpdateRolEvent>((event, emit) async {
      await _updateTipo(event: event, emit: emit);
    });
  }

  Future<void> _updateTipo(
      {required UpdateRolEvent event,
      required Emitter<EditarRolState> emit}) async {
    try {
      await _rolRespository.update(event.rol);
      emit(EditarRolSuccess(rol: event.rol, isEditing: true));
    } catch (e) {
      emit(EditarRolError(message: e.toString()));
    }
  }
}
