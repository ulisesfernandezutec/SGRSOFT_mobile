import 'package:sgrsoft/data/datasource/local/puntos_recoleccion/local.dart';
import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';
import 'package:sgrsoft/domain/repositories/puntos_recoleccion_repository.dart';

// Implemento el Punto de Recoleccion Repository.
class PuntosRecoleccionRepository extends AbstractPuntosRecoleccionRepository {
  final RemotePuntosRecoleccionDataSource _remote;
  // ignore: unused_field
  final LocalPuntosRecoleccionDataSource _local;

  PuntosRecoleccionRepository(this._remote, this._local);

  @override
  Future<List<PuntoRecoleccion>> getPuntosRecoleccion(
      {bool updateLocal = false}) async {
    // if(updateLocal){
    //   await _local.clear();
    //   await _local.addPuntosRecoleccion(await _remote.getPuntosRecoleccion());
    // }
    List<PuntoRecoleccion> listRemote = await _remote.getPuntosRecoleccion();
    // List<PuntoRecoleccion> listLocal = await _local.getPuntosRecoleccion();
    return listRemote;
  }

  @override
  Future<bool> addPuntoRecoleccion(PuntoRecoleccion puntoRecoleccion) async {
    return await _remote.addPuntoRecoleccion(puntoRecoleccion);
  }

  @override
  Future<bool> updatePuntoRecoleccion(PuntoRecoleccion puntoRecoleccion) async {
    return await _remote.updatePuntoRecoleccion(puntoRecoleccion);
  }

  @override
  Future<bool> deletePuntoRecoleccion(PuntoRecoleccion puntoRecoleccion) async {
    return await _remote.deletePuntoRecoleccion(puntoRecoleccion);
  }
}
