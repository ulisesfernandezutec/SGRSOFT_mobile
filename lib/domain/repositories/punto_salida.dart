import 'package:sgrsoft/domain/models/punto_salida.dart';

abstract class AbstractPuntoSalidaRepository {
  Future<List<PuntoSalida>> getList({bool updateLocal = false});
  Future<PuntoSalida> get(int id);
  Future<bool> add(PuntoSalida puntoSalida);
  Future<bool> update(PuntoSalida puntoSalida);
  Future<bool> delete(PuntoSalida puntoSalida);
}
