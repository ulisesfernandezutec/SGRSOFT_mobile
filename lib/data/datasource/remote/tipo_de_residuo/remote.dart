import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';

abstract class RemoteTiposDeResiduosDataSource {
  Future<List<TipoDeResiduo>> getTiposDeResiduos();
  Future<TipoDeResiduo> getTipoDeResiduo(int id);
  Future<bool> addTipoDeResiduo(TipoDeResiduo tipoResiduo);
  Future<bool> updateTipoDeResiduo(TipoDeResiduo tipoResiduo);
  Future<bool> deleteTipoDeResiduo(TipoDeResiduo tipoResiduo);
}
