// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/tipos_de_residuos.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';

part 'editar_event.dart';
part 'editar_state.dart';

final getIt = GetIt.instance;

class EditarTipoDeResiduoBloc
    extends Bloc<EditarTipoDeResiduoEvent, EditarTipoDeResiduoState> {
  final TiposDeResiduosRepository _tiposDeResiduosRespository = getIt();

  EditarTipoDeResiduoBloc() : super(const EditarTipoDeResiduoInitial()) {
    on<UpdateTipoDeResiduoEvent>((event, emit) async {
      await _updateTipo(event: event, emit: emit);
    });
  }

  Future<void> _updateTipo(
      {required UpdateTipoDeResiduoEvent event,
      required Emitter<EditarTipoDeResiduoState> emit}) async {
    try {
      await _tiposDeResiduosRespository.updateTipoDeResiduo(event.tipoResiduo);
      emit(EditarTipoDeResiduoSuccess(
          tipoResiduo: event.tipoResiduo, isEditing: true));
    } catch (e) {
      emit(EditarTipoDeResiduoError(message: e.toString()));
    }
  }
}
