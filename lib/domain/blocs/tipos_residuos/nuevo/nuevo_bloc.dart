// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/tipos_de_residuos.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';

part 'nuevo_event.dart';
part 'nuevo_state.dart';

final getIt = GetIt.instance;

class NuevoTipoDeResiduoBloc
    extends Bloc<NuevoTipoDeResiduoEvent, NuevoTipoDeResiduoState> {
  final TiposDeResiduosRepository _tiposDeResiduosRespository = getIt();

  NuevoTipoDeResiduoBloc() : super(NuevoTipoDeResiduoInitialState()) {
    on<SaveNuevoTipoDeResiduoEvent>((event, emit) async {
      await _save(event.tipoDeResiduo, emit);
    });
  }

  Future<void> _save(TipoDeResiduo tipoDeResiduo,
      Emitter<NuevoTipoDeResiduoState> emit) async {
    emit(NuevoTipoDeResiduoLoadingState());
    try {
      await _tiposDeResiduosRespository.addTipoDeResiduo(tipoDeResiduo);
      emit(NuevoTipoDeResiduoSuccessState(tipoDeResiduo: tipoDeResiduo));
    } catch (e) {
      emit(NuevoTipoDeResiduoErrorState(message: e.toString()));
    }
  }
}
