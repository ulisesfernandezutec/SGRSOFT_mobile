import 'package:sgrsoft/domain/models/vehiculo.dart';

abstract class AbstractVehiculoRepository {
  Future<List<Vehiculo>> getList({bool updateLocal = false});
  Future<Vehiculo> get(int id);
  Future<bool> add(Vehiculo vehiculo);
  Future<bool> update(Vehiculo vehiculo);
  Future<bool> delete(Vehiculo vehiculo);
}
