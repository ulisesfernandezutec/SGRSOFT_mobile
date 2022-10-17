import 'package:get_it/get_it.dart';
import 'package:sgrsoft/di/puntos_recoleccion.dart';
import 'package:sgrsoft/ui/view_model/puntos_recoleccion/listado/listado.dart';

final GetIt _l = GetIt.instance;

Future<void> initializeDI() async {
  data();
  domain();
  view();
}

void data() async {
  puntosRecoleccionGetIt(_l);
}

void domain() async {
  _l.registerLazySingleton(() => _l<GetIt>());
}

void view() async {
  _l.registerFactory(() => ListadoPuntosRecoleccionModel(_l()));
}
