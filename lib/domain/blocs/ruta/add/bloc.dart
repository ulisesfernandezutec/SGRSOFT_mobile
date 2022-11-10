import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/data/streams/puntos_recoleccion/listado.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/ui/asset_store/image_store.dart';
import 'package:sgrsoft/ui/widgets/google_maps/lineas.dart';

part 'event.dart';
part 'state.dart';

final getIt = GetIt.instance;

class AddRutaBloc extends Bloc<AddRutaEvent, AddRutaState> {
  final StreamListadoPuntosRecoleccion _streamListadoPuntosRecoleccion =
      getIt();

  AddRutaBloc() : super(AddRutaInitialState()) {
    on<LoadAddRutaEvent>((event, emit) async {
      await _init(event: event, emit: emit);
    });
  }

  Future<void> _init(
      {required AddRutaEvent event,
      required Emitter<AddRutaState> emit}) async {
    List<PuntoRecoleccion> puntos =
        await _streamListadoPuntosRecoleccion.puntos;
    Map<PolylineId, Polyline> pls = await getPolylines(puntos);
    Set<Polyline> polylines = Set<Polyline>.of(pls.values);
    Set<Marker> markers = Set.of(puntos
        .map((e) => Marker(
              markerId: MarkerId(e.id.toString()),
              position: LatLng(e.latitud, e.longitud),
              icon: ImageStore().markerIcon,
            ))
        .toList());
    emit(AddRutaReadyState(
        puntosRecoleccion: puntos, polylines: polylines, markers: markers));
  }
}
