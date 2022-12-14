import 'package:sgrsoft/domain/models/usuario.dart';

abstract class AbstractUsuarioRepository {
  Future<List<Usuario>> getList({bool updateLocal = false});
  Future<Usuario> get(int id);
  Future<bool> add(Usuario usuario);
  Future<bool> update(Usuario usuario);
  Future<bool> delete(Usuario usuario);
  Future<bool> registrar(Usuario usuario);
}
