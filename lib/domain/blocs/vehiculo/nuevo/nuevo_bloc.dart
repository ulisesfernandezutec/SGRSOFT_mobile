// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/vehiculo.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';

part 'nuevo_event.dart';
part 'nuevo_state.dart';

final getIt = GetIt.instance;

class NuevoVehiculoBloc extends Bloc<NuevoVehiculoEvent, NuevoVehiculoState> {
  final VehiculoRepository _vehiculoRespository = getIt();

  NuevoVehiculoBloc() : super(NuevoVehiculoInitialState()) {
    on<SaveNuevoVehiculoEvent>((event, emit) async {
      await _save(event.vehiculo, emit);
    });
  }

  Future<void> _save(
      Vehiculo vehiculo, Emitter<NuevoVehiculoState> emit) async {
    emit(NuevoVehiculoLoadingState());
    try {
      await _vehiculoRespository.add(vehiculo);
      emit(NuevoVehiculoSuccessState(vehiculo: vehiculo));
    } catch (e) {
      emit(NuevoVehiculoErrorState(message: e.toString()));
    }
  }
}
