// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/punto_disposicion_final_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';

part 'listado_event.dart';
part 'listado_state.dart';

final getIt = GetIt.instance;

class ListadoPuntoDisposicionFinalBloc extends Bloc<
    ListadoPuntoDisposicionFinalEvent, ListadoPuntoDisposicionFinalState> {
  final PuntoDisposicionFinalRepository _puntoDisposicionFinalRespository =
      getIt();

  ListadoPuntoDisposicionFinalBloc()
      : super(ListadoPuntoDisposicionFinalInitial()) {
    on<ListadoPuntoDisposicionFinalEventCargar>((event, emit) async {
      List<PuntoDisposicionFinal> puntos =
          await _puntoDisposicionFinalRespository.getList();
      emit(ListadoPuntoDisposicionFinalLoaded(puntos: puntos));
    });
  }
}
