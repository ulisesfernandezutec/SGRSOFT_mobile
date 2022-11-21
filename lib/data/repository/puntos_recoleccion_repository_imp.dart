import 'package:sgrsoft/data/datasource/local/puntos_recoleccion/local.dart';
import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/domain/repositories/puntos_recoleccion_repository.dart';

// Implemento el Punto de Recoleccion Repository.
class PuntosRecoleccionRepository extends AbstractPuntosRecoleccionRepository {
  final RemotePuntosRecoleccionDataSource _remote;
  // ignore: unused_field
  final LocalPuntosRecoleccionDataSource _local;

  PuntosRecoleccionRepository(this._remote, this._local);

  @override
  Future<List<PuntoRecoleccion>> getList({bool updateLocal = false}) async {
    // if(updateLocal){
    //   await _local.clear();
    //   await _local.addPuntosRecoleccion(await _remote.getList());
    // }
    List<PuntoRecoleccion> listRemote = await _remote.getList();
    // List<PuntoRecoleccion> listLocal = await _local.getList();
    return listRemote;
  }

  @override
  Future<PuntoRecoleccion> get(int id) async {
    return await _remote.get(id);
  }

  @override
  Future<bool> add(PuntoRecoleccion puntoRecoleccion) async {
    return await _remote.add(puntoRecoleccion);
  }

  @override
  Future<bool> update(PuntoRecoleccion puntoRecoleccion) async {
    return await _remote.update(puntoRecoleccion);
  }

  @override
  Future<bool> delete(PuntoRecoleccion puntoRecoleccion) async {
    return await _remote.delete(puntoRecoleccion);
  }
}
