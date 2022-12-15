import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/remote/ruta/api_ruta_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/ruta/mock_ruta_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/ruta/remote.dart';
import 'package:sgrsoft/data/repository/ruta_repository_imp.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
// import 'package:sgrsoft/domain/models/ruta.dart';

void rutasGetIt(GetIt gi) async {
  List<Ruta> list = [];
  // RemoteRutaDataSource remoteRutaDataSource =
  //     ApiRutaDataSource(db: <Ruta>[]);
  RemoteRutaDataSource remoteRutaDataSource = MockRutaDataSource(db: list);
  // RemoteRutaDataSource remoteRutaDataSource = ApiRutaDataSource(db: []);

  gi.registerSingleton<RutaRepository>(RutaRepository(remoteRutaDataSource));
}
