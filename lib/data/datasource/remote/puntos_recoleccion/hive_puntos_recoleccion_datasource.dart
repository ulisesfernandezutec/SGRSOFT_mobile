import 'package:hive/hive.dart';
import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

class HivePuntosRecoleccionDataSource
    extends RemotePuntosRecoleccionDataSource {
  final Box box;

  HivePuntosRecoleccionDataSource({required this.box});

  @override
  Future<List<PuntoRecoleccion>> getPuntosRecoleccion() async {
    List<PuntoRecoleccion> list = [];
    return list;
  }

  @override
  Future<bool> addPuntoRecoleccion(PuntoRecoleccion puntoRecoleccion) async {
    await box.add(puntoRecoleccion);
    return true;
  }

  @override
  Future<bool> deletePuntoRecoleccion(PuntoRecoleccion puntoRecoleccion) {
    // TODO: implement deletePuntoRecoleccion
    throw UnimplementedError();
  }

  @override
  Future<bool> updatePuntoRecoleccion(PuntoRecoleccion puntoRecoleccion) {
    // TODO: implement updatePuntoRecoleccion
    throw UnimplementedError();
  }
}
