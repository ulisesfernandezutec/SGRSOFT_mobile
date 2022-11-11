import 'package:sgrsoft/domain/models/vehiculo.dart';

abstract class RemoteVehiculoDataSource {
  Future<List<Vehiculo>> getList();
  Future<Vehiculo> get(int id);
  Future<bool> add(Vehiculo vehiculo);
  Future<bool> update(Vehiculo vehiculo);
  Future<bool> delete(Vehiculo vehiculo);
}
