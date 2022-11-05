import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/remote/tipo_de_residuo/api_tipo_de_residuo_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/tipo_de_residuo/mock_tipo_de_residuo_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/tipo_de_residuo/remote.dart';
import 'package:sgrsoft/data/repository/tipos_de_residuos.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';

void tiposDeResiduosGetIt(GetIt gi) async {
  List<TipoDeResiduo> list = [
    TipoDeResiduo(1, 'Podas'),
    TipoDeResiduo(2, 'Residuos grandes'),
    TipoDeResiduo(3, 'Pilas y Baterias'),
  ];
  // RemoteTiposDeResiduosDataSource remotePuntosRecoleccionDataSource =
  //     MockTiposDeResiduosDataSource(db: list);
  RemoteTiposDeResiduosDataSource remotePuntosRecoleccionDataSource =
      ApiTiposDeResiduosDataSource(db: <TipoDeResiduo>[]);
  gi.registerSingleton<TiposDeResiduosRepository>(
      TiposDeResiduosRepository(remotePuntosRecoleccionDataSource));
}
