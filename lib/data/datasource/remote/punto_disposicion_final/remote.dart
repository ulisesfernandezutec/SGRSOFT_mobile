import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';

abstract class RemotePuntoDisposicionFinalDataSource {
  Future<List<PuntoDisposicionFinal>> getList();
  Future<PuntoDisposicionFinal> get(int id);
  Future<bool> add(PuntoDisposicionFinal puntoDisposicionFinal);
  Future<bool> update(PuntoDisposicionFinal puntoDisposicionFinal);
  Future<bool> delete(PuntoDisposicionFinal puntoDisposicionFinal);
  Future<List<PuntoDisposicionFinal>> getListByIds(List<int> list);
}
