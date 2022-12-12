import 'package:sgrsoft/domain/models/tipo_residuo.dart';

class SearchPuntosRecoleccionObject {
  String? buscar;
  String? estado;
  DateTime? fechaInicio;
  DateTime? fechaFin;
  List<TipoDeResiduo>? tipos;

  SearchPuntosRecoleccionObject({
    this.buscar,
    this.estado,
    this.fechaInicio,
    this.fechaFin,
    this.tipos,
  });
}
