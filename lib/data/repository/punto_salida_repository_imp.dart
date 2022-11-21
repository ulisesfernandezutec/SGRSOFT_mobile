import 'package:sgrsoft/data/datasource/remote/punto_salida/remote.dart';
import 'package:sgrsoft/domain/models/punto_salida.dart';
import 'package:sgrsoft/domain/repositories/punto_salida.dart';

// Implemento el Punto de Recoleccion Repository.
class PuntoSalidaRepository extends AbstractPuntoSalidaRepository {
  final RemotePuntoSalidaDataSource _remote;

  PuntoSalidaRepository(this._remote);

  @override
  Future<List<PuntoSalida>> getList({bool updateLocal = false}) async {
    // if(updateLocal){
    //   await _local.clear();
    //   await _local.addPuntoSalida(await _remote.getList());
    // }
    List<PuntoSalida> listRemote = await _remote.getList();
    // List<PuntoSalida> listLocal = await _local.getList();
    return listRemote;
  }

  @override
  Future<PuntoSalida> get(int id) async {
    return await _remote.get(id);
  }

  @override
  Future<bool> add(PuntoSalida puntoSalida) async {
    return await _remote.add(puntoSalida);
  }

  @override
  Future<bool> update(PuntoSalida puntoSalida) async {
    return await _remote.update(puntoSalida);
  }

  @override
  Future<bool> delete(PuntoSalida puntoSalida) async {
    return await _remote.delete(puntoSalida);
  }
}
