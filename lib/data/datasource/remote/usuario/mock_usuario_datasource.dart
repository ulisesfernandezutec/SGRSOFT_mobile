import 'package:sgrsoft/data/datasource/remote/usuario/remote.dart';
import 'package:sgrsoft/domain/models/usuario.dart';

class MockUsuarioDataSource extends RemoteUsuarioDataSource {
  List<Usuario> db;

  MockUsuarioDataSource({required this.db});

  @override
  Future<List<Usuario>> getList() async {
    return db;
  }

  @override
  Future<Usuario> get(int id) async {
    if (db.isNotEmpty) {
      List<Usuario> usuarios = db.where((usuario) => usuario.id == id).toList();
      if (usuarios.isNotEmpty) {
        return usuarios[0];
      } else {
        throw Exception("No se encontró el usuario");
      }
    } else {
      throw Exception("No existen usuario para consultar");
    }
  }

  @override
  Future<bool> add(Usuario usuario) async {
    usuario.id = db.length + 1;
    db.add(usuario);
    return Future.value(true);
  }

  @override
  Future<bool> delete(Usuario usuario) {
    db.remove(usuario);
    return Future.value(true);
  }

  @override
  Future<bool> update(Usuario usuario) {
    db[db.indexWhere((usuario) => usuario.id == usuario.id)] = usuario;
    return Future.value(true);
  }

  @override
  Future<bool> registrar(Usuario usuario) {
    return add(usuario);
  }
}
