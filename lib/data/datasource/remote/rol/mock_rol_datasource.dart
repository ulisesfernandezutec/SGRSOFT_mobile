import 'package:sgrsoft/data/datasource/remote/rol/remote.dart';
import 'package:sgrsoft/domain/models/rol.dart';

class MockRolDataSource extends RemoteRolDataSource {
  List<Rol> db;

  MockRolDataSource({required this.db});

  @override
  Future<List<Rol>> getList() async {
    return db;
  }

  @override
  Future<Rol> get(int id) async {
    if (db.isNotEmpty) {
      List<Rol> puntos = db.where((punto) => punto.id == id).toList();
      if (puntos.isNotEmpty) {
        return puntos[0];
      } else {
        throw Exception("No se encontró el rol");
      }
    } else {
      throw Exception("No existen roles para consultar");
    }
  }

  @override
  Future<bool> add(Rol rol) async {
    rol.id = db.length + 1;
    db.add(rol);
    return Future.value(true);
  }

  @override
  Future<bool> delete(Rol rol) {
    db.remove(rol);
    return Future.value(true);
  }

  @override
  Future<bool> update(Rol rol) {
    db[db.indexWhere((punto) => punto.id == rol.id)] = rol;
    return Future.value(true);
  }
}
