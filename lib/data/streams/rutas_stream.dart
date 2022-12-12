import 'dart:async';
import 'dart:developer';

import 'package:sgrsoft/data/const/netconsts.dart';
import 'package:sgrsoft/data/repository/ruta_repository_imp.dart';
import 'package:sgrsoft/domain/models/ruta.dart';

class StreamListadoRutas {
  final RutaRepository _rutaRespository;
  late Timer _timer;
  bool _timerStarted = false;
  bool _refresh = false;
  List<Ruta> _rutas = [];

  get rutas => _rutas;

  final _streamController = StreamController<List<Ruta>>.broadcast();
  get stream => _streamController.stream;

  StreamListadoRutas(this._rutaRespository);

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
      try {
        _rutas = await _rutaRespository.getList();
        _streamController.sink.add(_rutas);
        _refresh = false;
      } catch (e) {
        log("Error en StreamListadoRutas.refresh: $e");
      }
    }
  }

  void close() {
    _streamController.close();
  }
}
