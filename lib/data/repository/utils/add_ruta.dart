import 'package:sgrsoft/domain/models/ruta.dart';
import 'package:sgrsoft/domain/models/ruta_punto.dart';

class AddRutaRepository {
  Ruta _ruta;
  AddRutaRepository(this._ruta);

  get ruta => _ruta;

  void updateRuta(Ruta ruta) {
    _ruta = ruta;
  }

  void addPunto(RutaPunto punto) {
    _ruta.puntos.add(punto);
  }

  void removePunto(RutaPunto punto) {
    _ruta.puntos.remove(punto);
  }

  // update puntos
  void updatePuntos(List<RutaPunto> puntos) {
    _ruta.puntos = puntos;
  }

  void clear() {
    _ruta = Ruta(puntos: []);
  }
}
