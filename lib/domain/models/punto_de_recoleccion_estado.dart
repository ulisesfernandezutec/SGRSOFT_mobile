import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'punto_de_recoleccion_estado.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class PuntoRecoleccionEstado {
  @HiveField(0)
  @JsonKey(name: '_id')
  int id;

  @HiveField(1)
  DateTime fecha;

  @HiveField(2)
  int usuario;

  @HiveField(3)
  String estado;

  @HiveField(4)
  String detalle;

  PuntoRecoleccionEstado(
      this.id, this.fecha, this.usuario, this.estado, this.detalle);

  factory PuntoRecoleccionEstado.fromJson(Map<String, dynamic> json) =>
      _$PuntoRecoleccionEstadoFromJson(json);

  Map<String, dynamic> toJson() => _$PuntoRecoleccionEstadoToJson(this);
}
