// Implemento el Punto de Recoleccion Repository.
import 'package:sgrsoft/data/datasource/remote/punto_disposicion_final/remote.dart';
import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';
import 'package:sgrsoft/domain/repositories/punto_disposicion_final.dart';

class PuntoDisposicionFinalRepository
    extends AbstractPuntoDisposicionFinalRepository {
  final RemotePuntoDisposicionFinalDataSource _remote;

  PuntoDisposicionFinalRepository(this._remote);

  @override
  Future<List<PuntoDisposicionFinal>> getList(
      {bool updateLocal = false}) async {
    // if(updateLocal){
    //   await _local.clear();
    //   await _local.addPuntoDisposicionFinal(await _remote.getList());
    // }
    List<PuntoDisposicionFinal> listRemote = await _remote.getList();
    // List<PuntoDisposicionFinal> listLocal = await _local.getList();
    return listRemote;
  }

  @override
  Future<PuntoDisposicionFinal> get(int id) async {
    return await _remote.get(id);
  }

  @override
  Future<bool> add(PuntoDisposicionFinal puntoDisposicionFinal) async {
    return await _remote.add(puntoDisposicionFinal);
  }

  @override
  Future<bool> update(PuntoDisposicionFinal puntoDisposicionFinal) async {
    return await _remote.update(puntoDisposicionFinal);
  }

  @override
  Future<bool> delete(PuntoDisposicionFinal puntoDisposicionFinal) async {
    return await _remote.delete(puntoDisposicionFinal);
  }
}
