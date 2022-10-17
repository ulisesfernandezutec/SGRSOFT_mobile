import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/local/puntos_recoleccion/local.dart';
import 'package:sgrsoft/data/datasource/local/puntos_recoleccion/mock_puntos_recoleccion_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/mock_puntos_recoleccion_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion_estado.dart';

void puntosRecoleccionGetIt(GetIt gi) async {
  List<PuntoRecoleccion> list = [
    PuntoRecoleccion(1, 10.3, 12.3, 'Recoleccion de Podas', 'Juan Ortiz 228',
        'Se corto un paraiso muy grande', [
      PuntoRecoleccionEstado(
          1, DateTime(2022, 10, 1), 1, 'Pendiente', 'Pendiente de recoleccion')
    ]),
    PuntoRecoleccion(2, 13.3, 14.3, 'Recoleccion de Muebles', 'Juan Ortiz 229',
        'Ropero de madera grande', [
      PuntoRecoleccionEstado(
          1, DateTime(2022, 10, 1), 1, 'Pendiente', 'Pendiente de recoleccion')
    ]),
  ];
  RemotePuntosRecoleccionDataSource remotePuntosRecoleccionDataSource =
      MockPuntosRecoleccionDataSource(db: list);
  LocalPuntosRecoleccionDataSource localPuntosRecoleccionDataSource =
      MockLocalPuntosRecoleccionDataSource(db: list);

  gi.registerSingleton<PuntosRecoleccionRepository>(PuntosRecoleccionRepository(
      remotePuntosRecoleccionDataSource, localPuntosRecoleccionDataSource));
}
