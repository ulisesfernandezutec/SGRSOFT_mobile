// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/data/repository/tipos_de_residuos.dart';
import 'package:sgrsoft/device/dev_geolocator.dart';
import 'package:sgrsoft/domain/blocs/puntos_recoleccion/listado/listado_bloc.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion_estado.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';

part 'nuevo_event.dart';
part 'nuevo_state.dart';

final getIt = GetIt.instance;

class NuevoPuntosRecoleccionBloc
    extends Bloc<NuevoPuntosRecoleccionEvent, NuevoPuntosRecoleccionBlocState> {
  final TiposDeResiduosRepository _tiposDeResiduosRepository = getIt();
  final PuntosRecoleccionRepository _puntosRecoleccionRepository = getIt();

  NuevoPuntosRecoleccionBloc()
      : super(NuevoInitialPuntosRecoleccionBlocState()) {
    on<LoadNuevoPuntosRecoleccionEvent>((event, emit) async {
      await _load(emit: emit);
    });
    on<SaveNuevoPuntosRecoleccionEvent>((event, emit) async {
      await _save(
          emit: emit,
          direccion: event.direccion,
          latitud: event.latitud,
          longitud: event.longitud,
          descripcion: event.descripcion,
          idTipoDeResiduo: event.idTipoDeResiduo);
    });
  }

  Future<void> _load(
      {required Emitter<NuevoPuntosRecoleccionBlocState> emit}) async {
    try {
      final tiposDeResiduos =
          await _tiposDeResiduosRepository.getTiposDeResiduos();
      final position = await determinePosition();
      emit(NuevoLoaderPuntosRecoleccionBlocState(
          tiposDeResiduos: tiposDeResiduos, position: position));
    } catch (e) {
      emit(NuevoErrorPuntosRecoleccionBlocState(message: e.toString()));
    }
  }

  Future<void> _save(
      {required Emitter<NuevoPuntosRecoleccionBlocState> emit,
      required String direccion,
      required double latitud,
      required double longitud,
      required String descripcion,
      required int idTipoDeResiduo}) async {
    try {
      TipoDeResiduo tipoDeResiduo =
          await _tiposDeResiduosRepository.getTipoDeResiduo(idTipoDeResiduo);

      PuntoRecoleccion puntoDeRecoleccion = PuntoRecoleccion(
          0,
          latitud,
          longitud,
          tipoDeResiduo,
          direccion,
          descripcion, <PuntoRecoleccionEstado>[]);

      await _puntosRecoleccionRepository
          .addPuntoRecoleccion(puntoDeRecoleccion);
      final position = await determinePosition();

      emit(NuevoLoaderPuntosRecoleccionBlocState(
          position: position, tiposDeResiduos: const []));
    } catch (e) {
      emit(NuevoErrorPuntosRecoleccionBlocState(message: e.toString()));
    }
  }
}
