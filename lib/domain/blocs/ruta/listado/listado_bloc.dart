// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/streams/rutas_stream.dart';
import 'package:sgrsoft/domain/models/ruta.dart';

part 'listado_event.dart';
part 'listado_state.dart';

final getIt = GetIt.instance;

class ListadoRutaBloc extends Bloc<ListadoRutaEvent, ListadoRutaState> {
  final StreamListadoRutas _streamListadoRutas = getIt();

  String _search = '';
  get getSearch => _search;
  List<Ruta> _filtered = <Ruta>[];
  List<Ruta> _rutas = <Ruta>[];

  ListadoRutaBloc() : super(ListadoRutaInitial()) {
    on<LoadListadoRutaEvent>((event, emit) async {
      _streamListadoRutas.timerStart();
      if (event.search.isNotEmpty) {
        _streamListadoRutas.refresh();
      }
      await _getRutas(event: event, emit: emit);
    });
    on<FiltedListadoRutaEvent>((event, emit) async {
      _search = event.search;
      await _filterRutas(
          event: event, emit: emit, search: event.search, rutas: _rutas);
    });
  }

  Future<void> _getRutas(
      {required LoadListadoRutaEvent event,
      required Emitter<ListadoRutaState> emit}) async {
    await emit.forEach(_streamListadoRutas.stream, onData: (List<Ruta> rutas) {
      _rutas = rutas;
      _filtered = searchFilter(rutas, _search);

      return ListadoRutaSuccess(rutas: _filtered, search: _search);
    }).catchError((error) => emit(const ListadoRutaError()));
  }

  Future<void> _filterRutas(
      {required FiltedListadoRutaEvent event,
      required Emitter<ListadoRutaState> emit,
      required String search,
      required List<Ruta> rutas}) async {
    _search = search;
    _filtered = searchFilter(rutas, search);
    // log('_filterPuntos: $search');
    emit(ListadoRutaSuccess(rutas: _filtered, search: search));
  }

  List<Ruta> searchFilter(List<Ruta> rutas, String search) {
    // log('searchFilter: $search');
    if (search.isNotEmpty) {
      // log('search not empy: $search');
      return rutas.where((element) {
        return element.nombre!.toLowerCase().contains(search.toLowerCase()) ||
            element.vehiculo!.matricula!
                .toLowerCase()
                .contains(search.toLowerCase()) ||
            element.administrador!.nombre!
                .toLowerCase()
                .contains(search.toLowerCase());
      }).toList();
    } else {
      // log('search empy: $search');
      return rutas;
    }
  }
}
