import 'package:hive/hive.dart';
import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';

class HivePuntosRecoleccionDataSource
    extends RemotePuntosRecoleccionDataSource {
  final Box box;

  HivePuntosRecoleccionDataSource({required this.box});

  @override
  Future<List<PuntoRecoleccion>> getList() async {
    List<PuntoRecoleccion> list = [];
    return list;
  }

  @override
  Future<PuntoRecoleccion> get(int id) async {
    // PuntoRecoleccion puntoRecoleccion = PuntoRecoleccion();
    // return db;
    throw UnimplementedError();
  }

  @override
  Future<bool> add(PuntoRecoleccion puntoRecoleccion) async {
    await box.add(puntoRecoleccion);
    return true;
  }

  @override
  Future<bool> delete(PuntoRecoleccion puntoRecoleccion) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<bool> update(PuntoRecoleccion puntoRecoleccion) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
