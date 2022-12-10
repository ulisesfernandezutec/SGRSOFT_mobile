import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/remote/vehiculo/api_vehiculo_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/vehiculo/mock_vehiculo_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/vehiculo/remote.dart';
import 'package:sgrsoft/data/repository/vehiculo.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';

void vehiculoGetIt(GetIt gi) async {
  List<Vehiculo> list = [
    Vehiculo(
        id: 1,
        nombre: 'Camion 1',
        matricula: 'ABC123',
        marca: 'Toyota',
        modelo: 'Corolla',
        chofer: 0),
    Vehiculo(
        id: 2,
        nombre: 'Camion 1',
        matricula: 'ABC321',
        marca: 'Toyota',
        modelo: 'Corolla',
        chofer: 2),
  ];
  RemoteVehiculoDataSource remoteVehiculoDataSource =
      MockVehiculoDataSource(db: list);
  gi.registerSingleton<VehiculoRepository>(
      VehiculoRepository(remoteVehiculoDataSource));
}
