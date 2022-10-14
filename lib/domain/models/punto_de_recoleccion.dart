import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion_estado.dart';

part 'punto_de_recoleccion.g.dart';

@JsonSerializable()
class PuntoRecoleccion {
  @JsonKey(name: '_id')
  int id;
  double latitud;
  double longitud;
  String tipo;
  String direccion;
  String descripcion;
  PuntoRecoleccionEstado? estado;

  PuntoRecoleccion(this.id, this.latitud, this.longitud, this.tipo,
      this.direccion, this.descripcion, this.estado);

  factory PuntoRecoleccion.fromJson(Map<String, dynamic> json) =>
      _$PuntoRecoleccionFromJson(json);

  Map<String, dynamic> toJson() => _$PuntoRecoleccionToJson(this);
}
