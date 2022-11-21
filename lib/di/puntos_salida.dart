import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/remote/punto_salida/mock_punto_salida_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/punto_salida/remote.dart';
import 'package:sgrsoft/data/repository/punto_salida_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_salida.dart';

void puntosSalidaGetIt(GetIt gi) async {
  List<PuntoSalida> list = [
    PuntoSalida(
      id: 1,
      latitud: -34.726449,
      longitud: -56.217088,
      direccion: 'Junta Departamental de Las Piedras',
      descripcion: 'Salida de camiones',
    ),
    PuntoSalida(
      id: 2,
      latitud: -34.718027,
      longitud: -56.237186,
      direccion: 'Cantera de Las Piedras',
      descripcion: 'Salida de camiones',
    )
  ];
  RemotePuntoSalidaDataSource remotePuntoSalidaDataSource =
      MockPuntoSalidaDataSource(db: list);

  gi.registerSingleton<PuntoSalidaRepository>(
      PuntoSalidaRepository(remotePuntoSalidaDataSource));
}
