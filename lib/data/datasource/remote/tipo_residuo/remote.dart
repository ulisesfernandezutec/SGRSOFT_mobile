import 'package:sgrsoft/domain/models/tipo_residuo.dart';

abstract class RemoteTiposDeResiduosDataSource {
  Future<List<TipoDeResiduo>> getList();
  Future<TipoDeResiduo> get(int id);
  Future<bool> add(TipoDeResiduo tipoResiduo);
  Future<bool> update(TipoDeResiduo tipoResiduo);
  Future<bool> delete(TipoDeResiduo tipoResiduo);
  Future<List<TipoDeResiduo>> getListByIds(List<int> list);
}
