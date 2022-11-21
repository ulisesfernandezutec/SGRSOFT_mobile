import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';

abstract class AbstractPuntoDisposicionFinalRepository {
  Future<List<PuntoDisposicionFinal>> getList({bool updateLocal = false});
  Future<PuntoDisposicionFinal> get(int id);
  Future<bool> add(PuntoDisposicionFinal puntoDisposicionFinal);
  Future<bool> update(PuntoDisposicionFinal puntoDisposicionFinal);
  Future<bool> delete(PuntoDisposicionFinal puntoDisposicionFinal);
}
