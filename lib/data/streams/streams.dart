import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/streams/puntos_recoleccion_stream.dart';
import 'package:sgrsoft/data/streams/rutas_stream.dart';

GetIt getIt = GetIt.instance;

// ignore: non_constant_identifier_names
void StartStreams() {
  final StreamListadoPuntosRecoleccion streamListadoPuntosRecoleccion = getIt();
  streamListadoPuntosRecoleccion.timerStart();
  final StreamListadoRutas streamListadoRutas = getIt();
  streamListadoRutas.timerStart();
}
