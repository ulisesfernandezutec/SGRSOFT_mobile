import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/domain/enums/punto_recoleccion_estados.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion_estado.dart';
import 'package:sgrsoft/domain/models/utils/search_puntos_recoleccion.dart';

class MockPuntosRecoleccionDataSource
    extends RemotePuntosRecoleccionDataSource {
  List<PuntoRecoleccion> db;

  MockPuntosRecoleccionDataSource({required this.db});

  @override
  Future<List<PuntoRecoleccion>> getList(
      SearchPuntosRecoleccionObject? search) async {
    List<PuntoRecoleccion> dbf = db;
    if (search == null) {
      return db;
    }
    if (search.buscar != null) {
      dbf = db
          .where((e) =>
              e.descripcion
                  .toLowerCase()
                  .contains(search.buscar!.toLowerCase()) ||
              e.direccion.toLowerCase().contains(search.buscar!.toLowerCase()))
          .toList();
    }
    bool checkTipo(int t) => search.tipos!.where((e) => e.id == t).isNotEmpty;
    if (search.tipos != null) {
      dbf = db.where((e) => checkTipo(e.tipo.id)).toList();
    }
    if (search.estado != null) {
      dbf = db
          .where((e) =>
              e.estados!.last.estado.toLowerCase() ==
              search.estado!.toLowerCase())
          .toList();
    }
    return dbf;
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
          0,
          DateTime.now(),
          1,
          PuntoRecoleccionEstadoOptions.pendiente.value,
          'Ingresado por el usuario'))
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
