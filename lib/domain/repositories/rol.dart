import 'package:sgrsoft/domain/models/rol.dart';

abstract class AbstractRolRepository {
  Future<List<Rol>> getList({bool updateLocal = false});
  Future<Rol> get(int id);
  Future<bool> add(Rol rol);
  Future<bool> update(Rol rol);
  Future<bool> delete(Rol rol);
}
