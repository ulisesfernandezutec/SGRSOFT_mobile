import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/streams/puntos_recoleccion/listado.dart';

import 'puntos_recoleccion.dart';
import 'rol.dart';
import 'tipos_de_residuos.dart';
import 'vehiculo.dart';

final GetIt _l = GetIt.instance;

Future<void> initializeDI() async {
  data();
  domain();
  streams();
  view();
}

void data() async {
  puntosRecoleccionGetIt(_l);
  tiposDeResiduosGetIt(_l);
  rolGetIt(_l);
  vehiculoGetIt(_l);
}

void domain() async {
  _l.registerLazySingleton(() => _l<GetIt>());
}

void streams() async {
  _l.registerSingleton<StreamListadoPuntosRecoleccion>(
      StreamListadoPuntosRecoleccion(_l.get()));
}

void view() async {}
