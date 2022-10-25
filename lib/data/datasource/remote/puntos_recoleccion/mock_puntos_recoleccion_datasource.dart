import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

class MockPuntosRecoleccionDataSource
    extends RemotePuntosRecoleccionDataSource {
  List<PuntoRecoleccion> db;

  MockPuntosRecoleccionDataSource({required this.db});

  @override
  Future<List<PuntoRecoleccion>> getPuntosRecoleccion() async {
    return db;
  }

  @override
  Future<PuntoRecoleccion> getPuntoRecoleccion(int id) async {
    if (db.isNotEmpty) {
      List<PuntoRecoleccion> puntos =
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
  Future<bool> addPuntoRecoleccion(PuntoRecoleccion puntoRecoleccion) async {
    db.add(puntoRecoleccion);
    return Future.value(true);
  }

  @override
  Future<bool> deletePuntoRecoleccion(PuntoRecoleccion puntoRecoleccion) {
    db.remove(puntoRecoleccion);
    return Future.value(true);
  }

  @override
  Future<bool> updatePuntoRecoleccion(PuntoRecoleccion puntoRecoleccion) {
    db[db.indexWhere((punto) => punto.id == puntoRecoleccion.id)] =
        puntoRecoleccion;
    return Future.value(true);
  }
}
