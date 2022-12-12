import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/domain/models/utils/search_puntos_recoleccion.dart';
import 'package:sgrsoft/domain/repositories/puntos_recoleccion_repository.dart';

// Implemento el Punto de Recoleccion Repository.
class PuntosRecoleccionRepository extends AbstractPuntosRecoleccionRepository {
  final RemotePuntosRecoleccionDataSource remote;

  PuntosRecoleccionRepository({required this.remote});

  @override
  Future<List<PuntoRecoleccion>> getList(
      {SearchPuntosRecoleccionObject? search}) async {
    List<PuntoRecoleccion> listRemote = await remote.getList(search);
    return listRemote;
  }

  @override
  Future<PuntoRecoleccion> get(int id) async {
    return await remote.get(id);
  }

  @override
  Future<bool> add(PuntoRecoleccion puntoRecoleccion) async {
    return await remote.add(puntoRecoleccion);
  }

  @override
  Future<bool> update(PuntoRecoleccion puntoRecoleccion) async {
    return await remote.update(puntoRecoleccion);
  }

  @override
  Future<bool> delete(PuntoRecoleccion puntoRecoleccion) async {
    return await remote.delete(puntoRecoleccion);
  }
}
