import 'package:sgrsoft/domain/models/punto_recoleccion.dart';

abstract class RemotePuntosRecoleccionDataSource {
  Future<List<PuntoRecoleccion>> getList();
  Future<PuntoRecoleccion> get(int id);
  Future<bool> add(PuntoRecoleccion puntoRecoleccion);
  Future<bool> update(PuntoRecoleccion puntoRecoleccion);
  Future<bool> delete(PuntoRecoleccion puntoRecoleccion);
}
