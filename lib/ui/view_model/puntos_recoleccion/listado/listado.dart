import 'package:sgrsoft/data/repository/puntos_recoleccion_repository_imp.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

class ListadoPuntosRecoleccionModel {
  PuntosRecoleccionRepository repository;
  List<PuntoRecoleccion> puntosRecoleccion = [];

  ListadoPuntosRecoleccionModel(this.repository);

  void getPuntosRecoleccion() async {
    puntosRecoleccion = await repository.getPuntosRecoleccion();
  }
}
