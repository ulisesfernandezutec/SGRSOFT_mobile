import 'package:get_it/get_it.dart';
import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/mock_puntos_recoleccion_datasource.dart';
import 'package:sgrsoft/data/datasource/remote/puntos_recoleccion/remote.dart';
import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion_estado.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';

void puntosRecoleccionGetIt(GetIt gi) async {
  List<PuntoRecoleccion> list = [
    PuntoRecoleccion(
        id: 1,
        latitud: -34.734501,
        longitud: -56.229366,
        tipo: TipoDeResiduo(id: 1, nombre: 'Podas'),
        direccion: 'Casa 1',
        descripcion: 'Se corto un paraiso muy grande',
        usuario: 0,
        estados: [
          PuntoRecoleccionEstado(1, DateTime(2022, 10, 1), 1, 'Pendiente',
              'Pendiente de recoleccion')
        ]),
    PuntoRecoleccion(
        id: 2,
        latitud: -34.725260,
        longitud: -56.201385,
        tipo: TipoDeResiduo(id: 2, nombre: 'Residuos grandes'),
        direccion: 'Casa 2',
        descripcion: 'Ropero de madera grande',
        usuario: 0,
        estados: [
          PuntoRecoleccionEstado(1, DateTime(2022, 5, 13), 1, 'Pendiente',
              'Pendiente de recoleccion')
        ]),
    PuntoRecoleccion(
        id: 3,
        latitud: -34.739191,
        longitud: -56.222028,
        tipo: TipoDeResiduo(id: 2, nombre: 'Residuos grandes'),
        direccion: 'Casa 3',
        descripcion: 'Ropero de madera grande3',
        usuario: 0,
        estados: [
          PuntoRecoleccionEstado(1, DateTime(2022, 7, 4), 1, 'Asignado',
              'Pendiente de recoleccion3')
        ]),
    PuntoRecoleccion(
        id: 4,
        latitud: -34.718100,
        longitud: -56.224860,
        tipo: TipoDeResiduo(id: 1, nombre: 'Podas'),
        direccion: 'Casa 4',
        descripcion: '4',
        usuario: 0,
        estados: [
          PuntoRecoleccionEstado(1, DateTime(2022, 4, 4), 1, 'Cancelado',
              'Pendiente de recoleccion4')
        ]),
    PuntoRecoleccion(
        id: 5,
        latitud: -34.892189,
        longitud: -56.186288,
        tipo: TipoDeResiduo(id: 1, nombre: 'Podas'),
        direccion: 'Plaza Independecia',
        descripcion: '4',
        usuario: 0,
        estados: [
          PuntoRecoleccionEstado(1, DateTime(2022, 4, 4), 1, 'Completado',
              'Pendiente de recoleccion4')
        ]),
    PuntoRecoleccion(
        id: 6,
        latitud: -34.895920,
        longitud: -56.159166,
        tipo: TipoDeResiduo(id: 1, nombre: 'Podas'),
        direccion: 'Parque Batlle',
        descripcion: '4',
        usuario: 0,
        estados: [
          PuntoRecoleccionEstado(1, DateTime(2022, 4, 4), 1, 'Pendiente',
              'Pendiente de recoleccion4')
        ]),
    PuntoRecoleccion(
        id: 7,
        latitud: -34.881056,
        longitud: -56.148802,
        tipo: TipoDeResiduo(id: 1, nombre: 'Podas'),
        direccion: 'Casmu',
        descripcion: '4',
        usuario: 0,
        estados: [
          PuntoRecoleccionEstado(1, DateTime(2022, 4, 4), 1, 'Asignado',
              'Pendiente de recoleccion4')
        ]),
  ];
  // RemotePuntosRecoleccionDataSource remotePuntosRecoleccionDataSource =
  //     ApiPuntosRecoleccionDataSource(db: <PuntoRecoleccion>[]);
  RemotePuntosRecoleccionDataSource remotePuntosRecoleccionDataSource =
      MockPuntosRecoleccionDataSource(db: list);

  gi.registerSingleton<PuntosRecoleccionRepository>(
      PuntosRecoleccionRepository(remote: remotePuntosRecoleccionDataSource));
}
