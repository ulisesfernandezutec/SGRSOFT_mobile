import 'package:sgrsoft/data/datasource/remote/tipo_residuo/remote.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';
import 'package:sgrsoft/domain/repositories/tipos_de_residuos.dart';

// Implemento el Punto de Recoleccion Repository.
class TiposDeResiduosRepository extends AbstractTiposDeResiduosRepository {
  final RemoteTiposDeResiduosDataSource _remote;

  TiposDeResiduosRepository(this._remote);

  @override
  Future<List<TipoDeResiduo>> getList({bool updateLocal = false}) async {
    // if(updateLocal){
    //   await _local.clear();
    //   await _local.addTiposDeResiduos(await _remote.getList());
    // }
    List<TipoDeResiduo> listRemote = await _remote.getList();
    // List<TipoDeResiduo> listLocal = await _local.getList();
    return listRemote;
  }

  @override
  Future<TipoDeResiduo> get(int id) async {
    return await _remote.get(id);
  }

  @override
  Future<bool> add(TipoDeResiduo puntoRecoleccion) async {
    return await _remote.add(puntoRecoleccion);
  }

  @override
  Future<bool> update(TipoDeResiduo puntoRecoleccion) async {
    return await _remote.update(puntoRecoleccion);
  }

  @override
  Future<bool> delete(TipoDeResiduo puntoRecoleccion) async {
    return await _remote.delete(puntoRecoleccion);
  }

  @override
  Future<List<TipoDeResiduo>> getListByIds(List<int> list) async {
    return await _remote.getListByIds(list);
  }
}
