import 'package:sgrsoft/data/datasource/remote/tipo_de_residuo/remote.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';
import 'package:sgrsoft/domain/repositories/tipos_de_residuos.dart';

// Implemento el Punto de Recoleccion Repository.
class TiposDeResiduosRepository extends AbstractTiposDeResiduosRepository {
  final RemoteTiposDeResiduosDataSource _remote;

  TiposDeResiduosRepository(this._remote);

  @override
  Future<List<TipoDeResiduo>> getTiposDeResiduos(
      {bool updateLocal = false}) async {
    // if(updateLocal){
    //   await _local.clear();
    //   await _local.addTiposDeResiduos(await _remote.getTiposDeResiduos());
    // }
    List<TipoDeResiduo> listRemote = await _remote.getTiposDeResiduos();
    // List<TipoDeResiduo> listLocal = await _local.getTiposDeResiduos();
    return listRemote;
  }

  @override
  Future<TipoDeResiduo> getTipoDeResiduo(int id) async {
    return await _remote.getTipoDeResiduo(id);
  }

  @override
  Future<bool> addTipoDeResiduo(TipoDeResiduo puntoRecoleccion) async {
    return await _remote.addTipoDeResiduo(puntoRecoleccion);
  }

  @override
  Future<bool> updateTipoDeResiduo(TipoDeResiduo puntoRecoleccion) async {
    return await _remote.updateTipoDeResiduo(puntoRecoleccion);
  }

  @override
  Future<bool> deleteTipoDeResiduo(TipoDeResiduo puntoRecoleccion) async {
    return await _remote.deleteTipoDeResiduo(puntoRecoleccion);
  }
}
