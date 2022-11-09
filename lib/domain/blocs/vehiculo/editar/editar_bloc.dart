// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/vehiculo.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';

part 'editar_event.dart';
part 'editar_state.dart';

final getIt = GetIt.instance;

class EditarVehiculoBloc
    extends Bloc<EditarVehiculoEvent, EditarVehiculoState> {
  final VehiculoRepository _vehiculoRespository = getIt();

  EditarVehiculoBloc() : super(const EditarVehiculoInitial()) {
    on<UpdateVehiculoEvent>((event, emit) async {
      await _updateTipo(event: event, emit: emit);
    });
  }

  Future<void> _updateTipo(
      {required UpdateVehiculoEvent event,
      required Emitter<EditarVehiculoState> emit}) async {
    try {
      await _vehiculoRespository.update(event.vehiculo);
      emit(EditarVehiculoSuccess(vehiculo: event.vehiculo, isEditing: true));
    } catch (e) {
      emit(EditarVehiculoError(message: e.toString()));
    }
  }
}
