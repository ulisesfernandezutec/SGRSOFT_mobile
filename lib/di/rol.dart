import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/remote/rol/api_rol_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/rol/remote.dart';
import 'package:sgrsoft/data/repository/rol.dart';
import 'package:sgrsoft/domain/models/rol.dart';

void rolGetIt(GetIt gi) async {
  // List<Rol> list = [
  //   Rol(1, 'Usuario'),
  //   Rol(2, 'Chofer'),
  //   Rol(3, 'Administrador'),
  // ];
  RemoteRolDataSource remoteRolDataSource = ApiRolDataSource(db: <Rol>[]);
  gi.registerSingleton<RolRepository>(RolRepository(remoteRolDataSource));
}
