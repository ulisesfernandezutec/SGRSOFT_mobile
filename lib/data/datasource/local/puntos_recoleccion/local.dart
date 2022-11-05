import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

abstract class LocalPuntosRecoleccionDataSource {
  Future<List<PuntoRecoleccion>> getList();
  Future<bool> add(PuntoRecoleccion puntoRecoleccion);
  Future<bool> update(PuntoRecoleccion puntoRecoleccion);
  Future<bool> delete(PuntoRecoleccion puntoRecoleccion);
  Future<bool> clear();
}
