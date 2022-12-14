import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sgrsoft/data/api/api_azure_maps.dart';
import 'package:sgrsoft/data/repository/punto_disposicion_final_repository_imp.dart';
import 'package:sgrsoft/data/repository/punto_salida_repository_imp.dart';
import 'package:sgrsoft/data/repository/ruta_repository_imp.dart';
import 'package:sgrsoft/data/repository/usuario.dart';
import 'package:sgrsoft/data/repository/utils/add_ruta.dart';
import 'package:sgrsoft/data/repository/vehiculo.dart';
import 'package:sgrsoft/data/streams/puntos_recoleccion_stream.dart';
import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';
import 'package:sgrsoft/domain/models/punto_mapa.dart';
import 'package:sgrsoft/domain/models/punto_salida.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/domain/models/ruta_punto.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:sgrsoft/domain/models/utils/search_puntos_recoleccion.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';

part 'nueva_event.dart';
part 'nueva_state.dart';

GetIt getIt = GetIt.instance;

class NuevaRutaBloc extends Bloc<NuevaRutaEvent, NuevaRutaState> {
  StreamListadoPuntosRecoleccion streamListadoPuntosRecoleccion = getIt();
  final VehiculoRepository _vehiculoRespository = getIt();
  final PuntoSalidaRepository _puntoSalidaRepository = getIt();
  final PuntoDisposicionFinalRepository _disposicionFinalRepository = getIt();
  final UsuarioRepository _usuarioRepository = getIt();
  final AddRutaRepository _addRutaRepository = getIt();
  final RutaRepository _rutaRepository = getIt();

  SearchPuntosRecoleccionObject objSearch = SearchPuntosRecoleccionObject();
  Ruta ruta = Ruta(
      id: 0,
      nombre: '',
      estado: 'Activa',
      distancia: 0.0,
      tiempoTrabajo: 0.0,
      tiempoTraslado: 0.0,
      optimizar: false);
  List<int> ids = [];

  NuevaRutaBloc() : super(NuevaRutaInitial()) {
    on<NuevaRutaEventInitialLoad>((event, emit) async {
      emit(NuevaRutaLoading());
      _addRutaRepository.clear();
      List<Usuario> usuarios = await _usuarioRepository.getList();
      List<Usuario> choferes = usuarios
          .where((element) => element.rol!.nombre == 'Chofer')
          .toList(growable: false);
      List<Usuario> administradores = usuarios
          .where((element) => element.rol!.nombre == 'Administrador')
          .toList(growable: false);

      emit(NuevaRutaDatos(
          ruta: ruta,
          vehiculos: await _vehiculoRespository.getList(),
          puntosSalida: await _puntoSalidaRepository.getList(),
          puntosDisposicionFinal: await _disposicionFinalRepository.getList(),
          choferes: choferes,
          administradores: administradores,
          puntos: await streamListadoPuntosRecoleccion.puntos,
          polylines: const []));
    });
    on<NuevaRutaEventSave>((event, emit) async {
      emit(NuevaRutaLoading());
      await _rutaRepository.add(ruta);
      emit(NuevaRutaSaved());
    });
    on<NuevaRutaEventChangeSalida>((event, emit) async {
      emit(NuevaRutaLoading());
      ruta.salida = await _puntoSalidaRepository.get(event.id);
      await emitNuevaRutaDatos(ruta, emit);
    });
    on<NuevaRutaEventChangeFinal>((event, emit) async {
      emit(NuevaRutaLoading());
      ruta.disposicionFinal = await _disposicionFinalRepository.get(event.id);
      await emitNuevaRutaDatos(ruta, emit);
    });
    on<NuevaRutaEventChangePuntos>((event, emit) async {
      emit(NuevaRutaLoading());
      if (ids.contains(event.id)) {
        ids.remove(event.id);
      } else {
        ids.add(event.id);
      }
      await emitNuevaRutaDatos(ruta, emit);
    });
    on<NuevaRutaEventChangeChofer>((event, emit) async {
      List<Usuario> usuarios = await _usuarioRepository.getList();
      ruta.chofer =
          usuarios.where((element) => element.id == event.id).toList()[0];
      await emitNuevaRutaDatos(ruta, emit);
    });
    on<NuevaRutaEventChangeVehiculo>((event, emit) async {
      List<Vehiculo> vehiculos = await _vehiculoRespository.getList();
      ruta.vehiculo =
          vehiculos.where((element) => element.id == event.id).toList()[0];
      await emitNuevaRutaDatos(ruta, emit);
    });
    on<NuevaRutaEventChangeNombre>((event, emit) async {
      ruta.nombre = event.nombre;
      await emitNuevaRutaDatos(ruta, emit);
    });
    on<NuevaRutaEventChangeFecha>((event, emit) async {
      ruta.fecha = event.fecha.millisecondsSinceEpoch;
      await emitNuevaRutaDatos(ruta, emit);
    });
    on<NuevaRutaEventChangeOptimizar>((event, emit) async {
      emit(NuevaRutaLoading());
      ruta.optimizar = event.optimizar;
      await emitNuevaRutaDatos(ruta, emit);
    });
  }

  Future<void> emitNuevaRutaDatos(
      Ruta ruta, Emitter<NuevaRutaState> emit) async {
    // Defino variables de polylines
    List<LatLng> polylines = [];
    // Armo la lista de los usuarios por tipo
    List<Usuario> usuarios = await _usuarioRepository.getList();
    List<Usuario> choferes = usuarios
        .where((element) => element.rol!.nombre == 'Chofer')
        .toList(growable: false);
    List<Usuario> administradores = usuarios
        .where((element) => element.rol!.nombre == 'Administrador')
        .toList(growable: false);

    // Armo la lista de puntos seleccionados
    List<PuntoMapa> puntos = await streamListadoPuntosRecoleccion.puntos;
    List<PuntoMapa> puntosSeleccionados =
        puntos.where((e) => ids.contains(e.id)).toList();
    List<RutaPunto> rutaPuntos = [];
    for (PuntoMapa p in puntosSeleccionados) {
      rutaPuntos.add(RutaPunto(
          punto: p,
          distancia: 0.0,
          tiempoTraslado: 0.0,
          tiempoTrabajo: 0.0,
          estado: 'En proceso'));
    }

    // Optimizo los putnos si es necesario
    ApiAzureMaps apiAzureMaps = ApiAzureMaps();
    ruta.puntos = rutaPuntos;
    ruta =
        await apiAzureMaps.procesRoute(ruta: ruta, optimizar: ruta.optimizar);

    if (ruta.puntos != null) {
      ids = [];
      for (RutaPunto p in ruta.puntos!) {
        ids.add(p.punto.id);
        log("punto id ${p.punto.direccion}");
      }
    }

    polylines = apiAzureMaps.polylines;

    // Emito el estado
    emit(NuevaRutaDatos(
        ruta: ruta,
        vehiculos: await _vehiculoRespository.getList(),
        puntosSalida: await _puntoSalidaRepository.getList(),
        puntosDisposicionFinal: await _disposicionFinalRepository.getList(),
        choferes: choferes,
        administradores: administradores,
        puntos: await streamListadoPuntosRecoleccion.puntos,
        polylines: polylines));
  }
}
