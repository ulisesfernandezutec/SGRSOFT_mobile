import 'dart:async';
import 'dart:developer';

import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/domain/models/utils/search_puntos_recoleccion.dart';

class StreamListadoPuntosRecoleccion {
  final PuntosRecoleccionRepository _puntoRecoleccionRespository;
  late Timer _timer;
  bool _timerStarted = false;
  bool _refresh = false;

  SearchPuntosRecoleccionObject _filter = SearchPuntosRecoleccionObject();
  List<PuntoRecoleccion> puntosRecoleccion = [];

  get puntos => puntosRecoleccion;

  final _streamController =
      StreamController<List<PuntoRecoleccion>>.broadcast();
  get stream => _streamController.stream;

  StreamListadoPuntosRecoleccion(this._puntoRecoleccionRespository);

  void timerStart({int seconds = NetConts.REFRESH_TIME}) {
    if (!_timerStarted) {
      refresh();
      _timer = Timer.periodic(Duration(seconds: seconds), (timer) {
        refresh();
      });
      _timerStarted = true;
    }
  }

  void timerStop() {
    _timer.cancel();
    _timerStarted = false;
  }

  Future<bool> refresh() async {
    if (!_refresh) {
      _refresh = true;
      try {
        puntosRecoleccion =
            await _puntoRecoleccionRespository.getList(search: _filter);
        _streamController.sink.add(puntosRecoleccion);
      } catch (e) {
        log("Error en StreamListadoPuntosRecoleccion.refresh: $e");
      }
      _refresh = false;
      return true;
    } else {
      return true;
    }
  }

  Future<bool> setFilter(SearchPuntosRecoleccionObject filter) async {
    _filter = filter;
    return await refresh();
  }

  void close() {
    _streamController.close();
  }
}
