import 'package:sgrsoft/domain/models/ruta.dart';

import 'remote.dart';

class MockRutaDataSource extends RemoteRutaDataSource {
  List<Ruta> db;

  MockRutaDataSource({required this.db});

  @override
  Future<List<Ruta>> getList() async {
    return db;
  }

  @override
  Future<Ruta> get(int id) async {
    if (db.isNotEmpty) {
      List<Ruta> puntos = db.where((punto) => punto.id == id).toList();
      if (puntos.isNotEmpty) {
        return puntos[0];
      } else {
        throw Exception("No se encontró ruta");
      }
    } else {
      throw Exception("No existen rutas para consultar");
    }
  }

  @override
  Future<bool> add(Ruta ruta) async {
    ruta.id = db.length + 1;
    db.add(ruta);
    return Future.value(true);
  }

  @override
  Future<bool> delete(Ruta ruta) {
    db.remove(ruta);
    return Future.value(true);
  }

  @override
  Future<bool> update(Ruta ruta) {
    db[db.indexWhere((punto) => punto.id == ruta.id)] = ruta;
    return Future.value(true);
  }
}
