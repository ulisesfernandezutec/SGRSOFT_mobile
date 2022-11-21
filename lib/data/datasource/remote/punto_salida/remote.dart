import 'package:sgrsoft/domain/models/punto_salida.dart';

abstract class RemotePuntoSalidaDataSource {
  Future<List<PuntoSalida>> getList();
  Future<PuntoSalida> get(int id);
  Future<bool> add(PuntoSalida puntoSalida);
  Future<bool> update(PuntoSalida puntoSalida);
  Future<bool> delete(PuntoSalida puntoSalida);
}
