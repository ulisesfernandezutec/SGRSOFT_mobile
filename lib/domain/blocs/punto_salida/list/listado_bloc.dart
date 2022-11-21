// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/punto_salida_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_salida.dart';

part 'listado_event.dart';
part 'listado_state.dart';

final getIt = GetIt.instance;

class ListadoPuntoSalidaBloc
    extends Bloc<ListadoPuntoSalidaEvent, ListadoPuntoSalidaState> {
  final PuntoSalidaRepository _puntoSalidaRespository = getIt();

  ListadoPuntoSalidaBloc() : super(ListadoPuntoSalidaInitial()) {
    on<ListadoPuntoSalidaEventCargar>((event, emit) async {
      List<PuntoSalida> puntos = await _puntoSalidaRespository.getList();
      emit(ListadoPuntoSalidaLoaded(puntos: puntos));
    });
  }
}
