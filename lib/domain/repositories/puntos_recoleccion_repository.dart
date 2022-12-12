import 'package:sgrsoft/data/repository/punto_disposicion_final_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/domain/models/utils/search_puntos_recoleccion.dart';

abstract class AbstractPuntosRecoleccionRepository {
  Future<List<PuntoRecoleccion>> getList(
      {SearchPuntosRecoleccionObject? search});
  Future<PuntoRecoleccion> get(int id);
  Future<bool> add(PuntoRecoleccion puntoRecoleccion);
  Future<bool> update(PuntoRecoleccion puntoRecoleccion);
  Future<bool> delete(PuntoRecoleccion puntoRecoleccion);
}
