import 'package:sgrsoft/data/datasource/remote/rol/remote.dart';
import 'package:sgrsoft/domain/models/rol.dart';
import 'package:sgrsoft/domain/repositories/rol.dart';

// Implemento el Punto de Recoleccion Repository.
class RolRepository extends AbstractRolRepository {
  final RemoteRolDataSource _remote;

  RolRepository(this._remote);

  @override
  Future<List<Rol>> getList({bool updateLocal = false}) async {
    // if(updateLocal){
    //   await _local.clear();
    //   await _local.addRol(await _remote.getList());
    // }
    List<Rol> listRemote = await _remote.getList();
    // List<Rol> listLocal = await _local.getList();
    return listRemote;
  }

  @override
  Future<Rol> get(int id) async {
    return await _remote.get(id);
  }

  @override
  Future<bool> add(Rol rol) async {
    return await _remote.add(rol);
  }

  @override
  Future<bool> update(Rol rol) async {
    return await _remote.update(rol);
  }

  @override
  Future<bool> delete(Rol rol) async {
    return await _remote.delete(rol);
  }
}
