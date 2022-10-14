import 'package:json_annotation/json_annotation.dart';

part 'punto_de_recoleccion_estado.g.dart';

@JsonSerializable()
class PuntoRecoleccionEstado {
  @JsonKey(name: '_id')
  int id;
  DateTime fecha;
  int usuario;
  String estado;

  PuntoRecoleccionEstado(this.id, this.fecha, this.usuario, this.estado);

  factory PuntoRecoleccionEstado.fromJson(Map<String, dynamic> json) =>
      _$PuntoRecoleccionEstadoFromJson(json);

  Map<String, dynamic> toJson() => _$PuntoRecoleccionEstadoToJson(this);
}
