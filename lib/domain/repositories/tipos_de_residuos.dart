import 'package:sgrsoft/domain/models/tipo_residuo.dart';

abstract class AbstractTiposDeResiduosRepository {
  Future<List<TipoDeResiduo>> getList({bool updateLocal = false});
  Future<TipoDeResiduo> get(int id);
  Future<bool> add(TipoDeResiduo puntoRecoleccion);
  Future<bool> update(TipoDeResiduo puntoRecoleccion);
  Future<bool> delete(TipoDeResiduo puntoRecoleccion);
  Future<List<TipoDeResiduo>> getListByIds(List<int> list);
}
