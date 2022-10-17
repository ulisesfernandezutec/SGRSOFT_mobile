import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

abstract class LocalPuntosRecoleccionDataSource {
  Future<List<PuntoRecoleccion>> getPuntosRecoleccion();
  Future<bool> addPuntoRecoleccion(PuntoRecoleccion puntoRecoleccion);
  Future<bool> updatePuntoRecoleccion(PuntoRecoleccion puntoRecoleccion);
  Future<bool> deletePuntoRecoleccion(PuntoRecoleccion puntoRecoleccion);
  Future<bool> clear();
}
