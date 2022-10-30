// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/data/repository/tipos_de_residuos.dart';
import 'package:sgrsoft/device/dev_geolocator.dart';
import 'package:sgrsoft/di/puntos_recoleccion.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion_estado.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';

part 'editar_event.dart';
part 'editar_state.dart';

final getIt = GetIt.instance;

class EditarPuntosRecoleccionBloc extends Bloc<EditarPuntosRecoleccionEvent,
    EditarPuntosRecoleccionBlocState> {
  final TiposDeResiduosRepository _tiposDeResiduosRepository = getIt();
  final PuntosRecoleccionRepository _puntosRecoleccionRepository = getIt();

  EditarPuntosRecoleccionBloc()
      : super(EditarInitialPuntosRecoleccionBlocState()) {
    // on<LoadEditarPuntosRecoleccionEvent>((event, emit) async {
    //   await _load(emit: emit, puntoRecoleccion: ev);
    // });
    // on<SaveEditarPuntosRecoleccionEvent>((event, emit) async {
    //   await _save(
    //       emit: emit,
    //       direccion: event.direccion,
    //       latitud: event.latitud,
    //       longitud: event.longitud,
    //       descripcion: event.descripcion,
    //       puntoRecoleccion: event.puntoRecoleccion);
    // });
  }

  // Future<void> _load(
  //     {required Emitter<EditarPuntosRecoleccionBlocState> emit,
  //     required puntoRecoleccion}) async {
  //   try {
  //     final tiposDeResiduos =
  //         await _tiposDeResiduosRepository.getTiposDeResiduos();
  //     final PuntoRecoleccion puntoRecoleccion =
  //         await _puntosRecoleccionRepository
  //             .getPuntoRecoleccion(puntoRecoleccion);
  //     final position = await determinePosition();
  //     emit(EditarLoaderPuntosRecoleccionBlocState(
  //         tiposDeResiduos: tiposDeResiduos,
  //         position: position,
  //         puntoRecoleccion: puntoRecoleccion));
  //   } catch (e) {
  //     emit(EditarErrorPuntosRecoleccionBlocState(message: e.toString()));
  //   }
  // }

  Future<void> _save(
      {required Emitter<EditarPuntosRecoleccionBlocState> emit,
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

      // emit(EditarLoaderPuntosRecoleccionBlocState(
      //     position: position, tiposDeResiduos: const []));
    } catch (e) {
      emit(EditarErrorPuntosRecoleccionBlocState(message: e.toString()));
    }
  }
}
