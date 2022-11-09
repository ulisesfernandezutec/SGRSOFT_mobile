import 'package:sgrsoft/domain/models/rol.dart';

abstract class RemoteRolDataSource {
  Future<List<Rol>> getList();
  Future<Rol> get(int id);
  Future<bool> add(Rol rol);
  Future<bool> update(Rol rol);
  Future<bool> delete(Rol rol);
}
