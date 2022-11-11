import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/remote/vehiculo/api_vehiculo_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/vehiculo/remote.dart';
import 'package:sgrsoft/data/repository/vehiculo.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';

void vehiculoGetIt(GetIt gi) async {
  List<Vehiculo> list = [
    Vehiculo(
        id: 1,
        nombre: 'para que nombre?',
        matricula: 'ABC123',
        marca: 'Toyota',
        modelo: 'Corolla',
        chofer: 0),
  ];
  RemoteVehiculoDataSource remoteVehiculoDataSource =
      ApiVehiculoDataSource(db: <Vehiculo>[]);
  gi.registerSingleton<VehiculoRepository>(
      VehiculoRepository(remoteVehiculoDataSource));
}
