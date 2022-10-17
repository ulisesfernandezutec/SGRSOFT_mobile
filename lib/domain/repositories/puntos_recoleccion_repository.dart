import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

abstract class AbstractPuntosRecoleccionRepository {
  Future<List<PuntoRecoleccion>> getPuntosRecoleccion(
      {bool updateLocal = false});
  Future<bool> addPuntoRecoleccion(PuntoRecoleccion puntoRecoleccion);
  Future<bool> updatePuntoRecoleccion(PuntoRecoleccion puntoRecoleccion);
  Future<bool> deletePuntoRecoleccion(PuntoRecoleccion puntoRecoleccion);
}
