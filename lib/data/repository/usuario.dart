import 'package:sgrsoft/data/datasource/remote/usuario/remote.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:sgrsoft/domain/repositories/usuario.dart';

// Implemento el Punto de Recoleccion Repository.
class UsuarioRepository extends AbstractUsuarioRepository {
  final RemoteUsuarioDataSource _remote;

  UsuarioRepository(this._remote);

  @override
  Future<List<Usuario>> getList({bool updateLocal = false}) async {
    // if(updateLocal){
    //   await _local.clear();
    //   await _local.addUsuario(await _remote.getList());
    // }
    List<Usuario> listRemote = await _remote.getList();
    // List<Usuario> listLocal = await _local.getList();
    return listRemote;
  }

  @override
  Future<Usuario> get(int id) async {
    return await _remote.get(id);
  }

  @override
  Future<bool> add(Usuario usuario) async {
    return await _remote.add(usuario);
  }

  @override
  Future<bool> update(Usuario usuario) async {
    return await _remote.update(usuario);
  }

  @override
  Future<bool> delete(Usuario usuario) async {
    return await _remote.delete(usuario);
  }
}
