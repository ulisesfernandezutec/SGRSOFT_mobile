import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

abstract class AbstractPuntosRecoleccionRepository {
  Future<List<PuntoRecoleccion>> getList({bool updateLocal = false});
  Future<PuntoRecoleccion> get(int id);
  Future<bool> add(PuntoRecoleccion puntoRecoleccion);
  Future<bool> update(PuntoRecoleccion puntoRecoleccion);
  Future<bool> delete(PuntoRecoleccion puntoRecoleccion);
}
