import 'package:sgrsoft/domain/models/usuario.dart';

abstract class RemoteUsuarioDataSource {
  Future<List<Usuario>> getList();
  Future<Usuario> get(int id);
  Future<bool> add(Usuario usuario);
  Future<bool> update(Usuario usuario);
  Future<bool> delete(Usuario usuario);
}
