// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/rol.dart';
import 'package:sgrsoft/domain/models/rol.dart';

part 'nuevo_event.dart';
part 'nuevo_state.dart';

final getIt = GetIt.instance;

class NuevoRolBloc extends Bloc<NuevoRolEvent, NuevoRolState> {
  final RolRepository _rolRespository = getIt();

  NuevoRolBloc() : super(NuevoRolInitialState()) {
    on<SaveNuevoRolEvent>((event, emit) async {
      await _save(event.rol, emit);
    });
  }

  Future<void> _save(Rol rol, Emitter<NuevoRolState> emit) async {
    emit(NuevoRolLoadingState());
    try {
      await _rolRespository.add(rol);
      emit(NuevoRolSuccessState(rol: rol));
    } catch (e) {
      emit(NuevoRolErrorState(message: e.toString()));
    }
  }
}
