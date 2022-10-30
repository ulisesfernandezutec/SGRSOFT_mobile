import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';

abstract class AbstractTiposDeResiduosRepository {
  Future<List<TipoDeResiduo>> getTiposDeResiduos({bool updateLocal = false});
  Future<TipoDeResiduo> getTipoDeResiduo(int id);
  Future<bool> addTipoDeResiduo(TipoDeResiduo puntoRecoleccion);
  Future<bool> updateTipoDeResiduo(TipoDeResiduo puntoRecoleccion);
  Future<bool> deleteTipoDeResiduo(TipoDeResiduo puntoRecoleccion);
}
