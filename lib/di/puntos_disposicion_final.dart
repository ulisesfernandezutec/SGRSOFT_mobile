import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/remote/punto_disposicion_final/mock_punto_disposicion_final_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/punto_disposicion_final/remote.dart';
import 'package:sgrsoft/data/repository/punto_disposicion_final_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';

void puntosDisposicionFinalGetIt(GetIt gi) async {
  List<PuntoDisposicionFinal> list = [
    PuntoDisposicionFinal(
      id: 1,
      nombre: "Usina 1",
      latitud: -34.026449,
      longitud: -56.217088,
      direccion: 'Usina 1',
      descripcion: 'Usina 1 desechos solidos',
      tipos: const [],
    ),
    PuntoDisposicionFinal(
        id: 2,
        nombre: "Usina 2",
        latitud: -34.118027,
        longitud: -56.237186,
        direccion: 'Usina 2',
        descripcion: 'Podas',
        tipos: const [])
  ];
  RemotePuntoDisposicionFinalDataSource remotePuntoDisposicionFinalDataSource =
      MockPuntoDisposicionFinalDataSource(db: list);

  gi.registerSingleton<PuntoDisposicionFinalRepository>(
      PuntoDisposicionFinalRepository(remotePuntoDisposicionFinalDataSource));
}
