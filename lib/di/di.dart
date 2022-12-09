import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/repository/utils/add_ruta.dart';
import 'package:sgrsoft/data/repository/utils/tmp_punto_salida.dart';
import 'package:sgrsoft/data/services/jwt_auth.dart';
import 'package:sgrsoft/data/streams/puntos_recoleccion_stream.dart';
import 'package:sgrsoft/data/streams/rutas_stream.dart';
import 'package:sgrsoft/di/usuario.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/domain/services/auth_provider.dart';

import 'puntos_disposicion_final.dart';
import 'puntos_recoleccion.dart';
import 'puntos_salida.dart';
import 'rol.dart';
import 'ruta.dart';
import 'tipos_de_residuos.dart';
import 'vehiculo.dart';

final GetIt _l = GetIt.instance;

Future<void> initializeDI() async {
  data();
  domain();
  streams();
  view();
}

void auth() async {
  _l.registerLazySingleton<AuthenticationProvider>(() => Auth());
}

void data() async {
  puntosRecoleccionGetIt(_l);
  puntosSalidaGetIt(_l);
  puntosDisposicionFinalGetIt(_l);
  tiposDeResiduosGetIt(_l);
  rolGetIt(_l);
  vehiculoGetIt(_l);
  rutasGetIt(_l);
  usuarioGetIt(_l);

  // ignore: prefer_const_literals_to_create_immutables
  _l.registerSingleton<AddRutaRepository>(AddRutaRepository(Ruta(puntos: [])));

  // Instacia auxiliar para el manejo de puntos de salida
  _l.registerSingleton<TmpPuntoSalidaRepository>(TmpPuntoSalidaRepository());
}

void domain() async {
  _l.registerLazySingleton(() => _l<GetIt>());
}

void streams() async {
  _l.registerSingleton<StreamListadoPuntosRecoleccion>(
      StreamListadoPuntosRecoleccion(_l.get()));
  _l.registerSingleton<StreamListadoRutas>(StreamListadoRutas(_l.get()));
}

void view() async {}
