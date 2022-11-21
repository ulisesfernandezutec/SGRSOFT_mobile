import 'package:sgrsoft/domain/models/punto_salida.dart';

import 'remote.dart';

class MockPuntoSalidaDataSource extends RemotePuntoSalidaDataSource {
  List<PuntoSalida> db;

  MockPuntoSalidaDataSource({required this.db});

  @override
  Future<List<PuntoSalida>> getList() async {
    return db;
  }

  @override
  Future<PuntoSalida> get(int id) async {
    if (db.isNotEmpty) {
      List<PuntoSalida> puntos = db.where((punto) => punto.id == id).toList();
      if (puntos.isNotEmpty) {
        return puntos[0];
      } else {
        throw Exception("No se encontró el punto de recolección");
      }
    } else {
      throw Exception("No existen puntos de recolección para consultar");
    }
  }

  @override
  Future<bool> add(PuntoSalida puntoSalida) async {
    puntoSalida.id = db.length + 1;
    db.add(puntoSalida);
    return Future.value(true);
  }

  @override
  Future<bool> delete(PuntoSalida puntoSalida) {
    db.remove(puntoSalida);
    return Future.value(true);
  }

  @override
  Future<bool> update(PuntoSalida puntoSalida) {
    db[db.indexWhere((punto) => punto.id == puntoSalida.id)] = puntoSalida;
    return Future.value(true);
  }
}
