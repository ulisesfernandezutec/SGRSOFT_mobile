import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/domain/models/utils/search_puntos_recoleccion.dart';

abstract class RemotePuntosRecoleccionDataSource {
  Future<List<PuntoRecoleccion>> getList(SearchPuntosRecoleccionObject? search);
  Future<PuntoRecoleccion> get(int id);
  Future<bool> add(PuntoRecoleccion puntoRecoleccion);
  Future<bool> update(PuntoRecoleccion puntoRecoleccion);
  Future<bool> delete(PuntoRecoleccion puntoRecoleccion);
}
