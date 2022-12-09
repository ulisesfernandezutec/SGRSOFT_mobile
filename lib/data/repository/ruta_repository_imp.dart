import 'package:sgrsoft/data/datasource/remote/ruta/remote.dart';
import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/domain/repositories/ruta_repository.dart';

// Implemento el Punto de Recoleccion Repository.
class RutaRepository extends AbstractRutaRepository {
  final RemoteRutaDataSource _remote;
  // ignore: unused_field
  // final LocalRutaDataSource _local;

  RutaRepository(this._remote);

  @override
  Future<List<Ruta>> getList({bool updateLocal = false}) async {
    // if(updateLocal){
    //   await _local.clear();
    //   await _local.addRuta(await _remote.getList());
    // }
    List<Ruta> listRemote = await _remote.getList();
    // List<Ruta> listLocal = await _local.getList();
    return listRemote;
  }

  @override
  Future<Ruta> get(int id) async {
    return await _remote.get(id);
  }

  @override
  Future<bool> add(Ruta ruta) async {
    return await _remote.add(ruta);
  }

  @override
  Future<bool> update(Ruta ruta) async {
    return await _remote.update(ruta);
  }

  @override
  Future<bool> delete(Ruta ruta) async {
    return await _remote.delete(ruta);
  }
}
