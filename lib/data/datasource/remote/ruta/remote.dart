import 'package:sgrsoft/domain/models/ruta.dart';

abstract class RemoteRutaDataSource {
  Future<List<Ruta>> getList();
  Future<Ruta> get(int id);
  Future<bool> add(Ruta ruta);
  Future<bool> update(Ruta ruta);
  Future<bool> delete(Ruta ruta);
}
