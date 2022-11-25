import 'package:sgrsoft/data/datasource/remote/tipo_residuo/remote.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';

class MockTiposDeResiduosDataSource extends RemoteTiposDeResiduosDataSource {
  List<TipoDeResiduo> db;

  MockTiposDeResiduosDataSource({required this.db});

  @override
  Future<List<TipoDeResiduo>> getList() async {
    return db;
  }

  @override
  Future<TipoDeResiduo> get(int id) async {
    if (db.isNotEmpty) {
      List<TipoDeResiduo> puntos = db.where((punto) => punto.id == id).toList();
      if (puntos.isNotEmpty) {
        return puntos[0];
      } else {
        throw Exception("No se encontró el tipo de residuo");
      }
    } else {
      throw Exception("No existen tipos de residuos para consultar");
    }
  }

  @override
  Future<bool> add(TipoDeResiduo tipoResiduo) async {
    tipoResiduo.id = db.length + 1;
    db.add(tipoResiduo);
    return Future.value(true);
  }

  @override
  Future<bool> delete(TipoDeResiduo tipoResiduo) {
    db.remove(tipoResiduo);
    return Future.value(true);
  }

  @override
  Future<bool> update(TipoDeResiduo tipoResiduo) {
    db[db.indexWhere((punto) => punto.id == tipoResiduo.id)] = tipoResiduo;
    return Future.value(true);
  }

  @override
  Future<List<TipoDeResiduo>> getListByIds(List<int> list) {
    return Future.value(db.where((punto) => list.contains(punto.id)).toList());
  }
}
