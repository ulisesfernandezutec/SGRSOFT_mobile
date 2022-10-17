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
