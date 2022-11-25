import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/remote/tipo_residuo/mock_tipo_residuo_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/tipo_residuo/remote.dart';
import 'package:sgrsoft/data/repository/tipos_residuos.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';

void tiposDeResiduosGetIt(GetIt gi) async {
  List<TipoDeResiduo> list = [
    TipoDeResiduo(1, 'Podas'),
    TipoDeResiduo(2, 'Residuos grandes'),
    TipoDeResiduo(3, 'Pilas y Baterias'),
  ];
  // RemoteTiposDeResiduosDataSource remotePuntosRecoleccionDataSource =
  //     MockTiposDeResiduosDataSource(db: list);
  RemoteTiposDeResiduosDataSource remotePuntosRecoleccionDataSource =
      MockTiposDeResiduosDataSource(db: list);
  gi.registerSingleton<TiposDeResiduosRepository>(
      TiposDeResiduosRepository(remotePuntosRecoleccionDataSource));
}
