import 'dart:async';

import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

class StreamListadoPuntosRecoleccion {
  final PuntosRecoleccionRepository _puntoRecoleccionRespository;
  late Timer _timer;
  bool _timerStarted = false;
  bool _refresh = false;
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

  void refresh() async {
    if (!_refresh) {
      _refresh = true;
      puntosRecoleccion = await _puntoRecoleccionRespository.getList();
      _streamController.sink.add(puntosRecoleccion);
      _refresh = false;
    }
  }

  void close() {
    _streamController.close();
  }
}
