import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';

import 'remote.dart';

class MockPuntoDisposicionFinalDataSource
    extends RemotePuntoDisposicionFinalDataSource {
  List<PuntoDisposicionFinal> db;

  MockPuntoDisposicionFinalDataSource({required this.db});

  @override
  Future<List<PuntoDisposicionFinal>> getList() async {
    return db;
  }

  @override
  Future<PuntoDisposicionFinal> get(int id) async {
    if (db.isNotEmpty) {
      List<PuntoDisposicionFinal> puntos =
          db.where((punto) => punto.id == id).toList();
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
  Future<bool> add(PuntoDisposicionFinal puntoDisposicionFinal) async {
    puntoDisposicionFinal.id = db.length + 1;
    db.add(puntoDisposicionFinal);
    return Future.value(true);
  }

  @override
  Future<bool> delete(PuntoDisposicionFinal puntoDisposicionFinal) {
    db.remove(puntoDisposicionFinal);
    return Future.value(true);
  }

  @override
  Future<bool> update(PuntoDisposicionFinal puntoDisposicionFinal) {
    db[db.indexWhere((punto) => punto.id == puntoDisposicionFinal.id)] =
        puntoDisposicionFinal;
    return Future.value(true);
  }
}
