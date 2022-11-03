import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion_estado.dart';

class MockPuntosRecoleccionDataSource
    extends RemotePuntosRecoleccionDataSource {
  List<PuntoRecoleccion> db;

  MockPuntosRecoleccionDataSource({required this.db});

  @override
  Future<List<PuntoRecoleccion>> getList() async {
    return db;
  }

  @override
  Future<PuntoRecoleccion> get(int id) async {
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
  Future<bool> add(PuntoRecoleccion puntoRecoleccion) async {
    puntoRecoleccion.id = db.length + 1;
    puntoRecoleccion.estados = <PuntoRecoleccionEstado>[
      (PuntoRecoleccionEstado(
          0, DateTime.now(), 1, 'Nuevo', 'Ingresado por el usuario'))
    ];
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
}
