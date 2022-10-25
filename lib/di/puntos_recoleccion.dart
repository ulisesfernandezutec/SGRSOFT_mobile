import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/local/puntos_recoleccion/local.dart';
import 'package:sgrsoft/data/datasource/local/puntos_recoleccion/mock_puntos_recoleccion_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/mock_puntos_recoleccion_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion_estado.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';

void puntosRecoleccionGetIt(GetIt gi) async {
  List<PuntoRecoleccion> list = [
    PuntoRecoleccion(1, 10.3, 12.3, TipoDeResiduo(1, 'Podas'), 'Juan Ortiz 228',
        'Se corto un paraiso muy grande', [
      PuntoRecoleccionEstado(
          1, DateTime(2022, 10, 1), 1, 'Pendiente', 'Pendiente de recoleccion')
    ]),
    PuntoRecoleccion(2, 13.3, 14.3, TipoDeResiduo(2, 'Residuos grandes'),
        'Juan Ortiz 229', 'Ropero de madera grande', [
      PuntoRecoleccionEstado(
          1, DateTime(2022, 5, 13), 1, 'Pendiente', 'Pendiente de recoleccion')
    ]),
    PuntoRecoleccion(3, 16.3, 16.3, TipoDeResiduo(2, 'Residuos grandes'),
        'Juan Ortiz 2293', 'Ropero de madera grande3', [
      PuntoRecoleccionEstado(
          1, DateTime(2022, 7, 4), 1, 'Pendiente3', 'Pendiente de recoleccion3')
    ]),
    PuntoRecoleccion(
        4, 16.3, 16.3, TipoDeResiduo(1, 'Podas'), 'Juan Ortiz 444', '4', [
      PuntoRecoleccionEstado(
          1, DateTime(2022, 4, 4), 1, 'Pendiente4', 'Pendiente de recoleccion4')
    ]),
  ];
  RemotePuntosRecoleccionDataSource remotePuntosRecoleccionDataSource =
      MockPuntosRecoleccionDataSource(db: list);
  LocalPuntosRecoleccionDataSource localPuntosRecoleccionDataSource =
      MockLocalPuntosRecoleccionDataSource(db: list);

  gi.registerSingleton<PuntosRecoleccionRepository>(PuntosRecoleccionRepository(
      remotePuntosRecoleccionDataSource, localPuntosRecoleccionDataSource));
}
