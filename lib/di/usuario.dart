import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/remote/usuario/api_usuario_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/usuario/mock_usuario_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/usuario/remote.dart';
import 'package:sgrsoft/data/repository/usuario.dart';
import 'package:sgrsoft/domain/models/rol.dart';
import 'package:sgrsoft/domain/models/usuario.dart';

void usuarioGetIt(GetIt gi) async {
  // List<Usuario> list = [
  //   Usuario(
  //       apellido: "Fernández",
  //       nombre: "Ulises",
  //       id: 1,
  //       rol: Rol(3, 'Administrador')),
  //   Usuario(apellido: "Castro", nombre: "Cesar", id: 1, rol: Rol(2, 'Chofer')),
  //   Usuario(apellido: "Casa", nombre: "Veronica", id: 1, rol: Rol(1, 'Usuario'))
  // ];
  // RemoteUsuarioDataSource remoteUsuarioDataSource =
  //     MockUsuarioDataSource(db: list);
  // gi.registerSingleton<UsuarioRepository>(
  //     UsuarioRepository(remoteUsuarioDataSource));
  RemoteUsuarioDataSource remoteUsuarioDataSource =
      ApiUsuarioDataSource(db: []);
  gi.registerSingleton<UsuarioRepository>(
      UsuarioRepository(remoteUsuarioDataSource));
}
