import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion_estado.dart';
import 'package:hive/hive.dart';
import 'package:sgrsoft/domain/models/tipo_de_residuo.dart';

part 'punto_de_recoleccion.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class PuntoRecoleccion {
  @HiveField(0)
  @JsonKey(name: '_id')
  int id;

  @HiveField(1)
  double latitud;

  @HiveField(2)
  double longitud;

  @HiveField(3)
  TipoDeResiduo tipo;

  @HiveField(4)
  String direccion;

  @HiveField(5)
  String descripcion;

  @HiveField(6)
  List<PuntoRecoleccionEstado>? estados;

  PuntoRecoleccion(this.id, this.latitud, this.longitud, this.tipo,
      this.direccion, this.descripcion, this.estados);

  factory PuntoRecoleccion.fromJson(Map<String, dynamic> json) =>
      _$PuntoRecoleccionFromJson(json);

  Map<String, dynamic> toJson() => _$PuntoRecoleccionToJson(this);
}
