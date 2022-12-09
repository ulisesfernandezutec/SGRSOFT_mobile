import 'package:sgrsoft/domain/models/ruta.dart';

abstract class AbstractRutaRepository {
  Future<List<Ruta>> getList({bool updateLocal = false});
  Future<Ruta> get(int id);
  Future<bool> add(Ruta ruta);
  Future<bool> update(Ruta ruta);
  Future<bool> delete(Ruta ruta);
}
