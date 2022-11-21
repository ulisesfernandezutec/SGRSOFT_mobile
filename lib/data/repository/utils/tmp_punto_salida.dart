import 'package:sgrsoft/domain/models/punto_salida.dart';

class TmpPuntoSalidaRepository {
  PuntoSalida _punto = PuntoSalida(
      id: 0, descripcion: '', direccion: '', latitud: 0, longitud: 0);

  TmpPuntoSalidaRepository();

  get punto => _punto;

  void set(PuntoSalida punto) {
    _punto = punto;
  }

  void clear() {
    _punto = PuntoSalida(
        id: 0, descripcion: '', direccion: '', latitud: 0, longitud: 0);
  }
}
