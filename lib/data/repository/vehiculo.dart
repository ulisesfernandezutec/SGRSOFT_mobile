import 'package:sgrsoft/data/datasource/remote/vehiculo/remote.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';
import 'package:sgrsoft/domain/repositories/vehiculo.dart';

// Implemento el Punto de Recoleccion Repository.
class VehiculoRepository extends AbstractVehiculoRepository {
  final RemoteVehiculoDataSource _remote;

  VehiculoRepository(this._remote);

  @override
  Future<List<Vehiculo>> getList({bool updateLocal = false}) async {
    // if(updateLocal){
    //   await _local.clear();
    //   await _local.addVehiculo(await _remote.getList());
    // }
    List<Vehiculo> listRemote = await _remote.getList();
    // List<Vehiculo> listLocal = await _local.getList();
    return listRemote;
  }

  @override
  Future<Vehiculo> get(int id) async {
    return await _remote.get(id);
  }

  @override
  Future<bool> add(Vehiculo vehiculo) async {
    return await _remote.add(vehiculo);
  }

  @override
  Future<bool> update(Vehiculo vehiculo) async {
    return await _remote.update(vehiculo);
  }

  @override
  Future<bool> delete(Vehiculo vehiculo) async {
    return await _remote.delete(vehiculo);
  }
}
