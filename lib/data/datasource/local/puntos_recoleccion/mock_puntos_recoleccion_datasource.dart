import 'package:sgrsoft/data/datasource/local/puntos_recoleccion/local.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

class MockLocalPuntosRecoleccionDataSource
    extends LocalPuntosRecoleccionDataSource {
  List<PuntoRecoleccion> db;

  MockLocalPuntosRecoleccionDataSource({required this.db});

  @override
  Future<List<PuntoRecoleccion>> getList() async {
    return db;
  }

  @override
  Future<bool> add(PuntoRecoleccion puntoRecoleccion) async {
    db.add(puntoRecoleccion);
    return Future.value(true);
  }

  @override
  Future<bool> delete(PuntoRecoleccion puntoRecoleccion) {
    db.remove(puntoRecoleccion);
    return Future.value(true);
  }

  @override
  Future<bool> update(PuntoRecoleccion puntoRecoleccion) {
    db[db.indexWhere((punto) => punto.id == puntoRecoleccion.id)] =
        puntoRecoleccion;
    return Future.value(true);
  }

  @override
  Future<bool> clear() {
    // ignore: todo
    // TODO: implement clear
    throw UnimplementedError();
  }
}
