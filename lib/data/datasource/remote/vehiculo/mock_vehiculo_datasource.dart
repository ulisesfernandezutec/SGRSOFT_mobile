import 'package:sgrsoft/data/datasource/remote/vehiculo/remote.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';

class MockVehiculoDataSource extends RemoteVehiculoDataSource {
  List<Vehiculo> db;

  MockVehiculoDataSource({required this.db});

  @override
  Future<List<Vehiculo>> getList() async {
    return db;
  }

  @override
  Future<Vehiculo> get(int id) async {
    if (db.isNotEmpty) {
      List<Vehiculo> vehiculos =
          db.where((vehiculo) => vehiculo.id == id).toList();
      if (vehiculos.isNotEmpty) {
        return vehiculos[0];
      } else {
        throw Exception("No se encontró el vehiculo");
      }
    } else {
      throw Exception("No existen vehiculo para consultar");
    }
  }

  @override
  Future<bool> add(Vehiculo vehiculo) async {
    vehiculo.id = db.length + 1;
    db.add(vehiculo);
    return Future.value(true);
  }

  @override
  Future<bool> delete(Vehiculo vehiculo) {
    db.remove(vehiculo);
    return Future.value(true);
  }

  @override
  Future<bool> update(Vehiculo vehiculo) {
    db[db.indexWhere((vehiculo) => vehiculo.id == vehiculo.id)] = vehiculo;
    return Future.value(true);
  }
}
