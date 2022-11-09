import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/punto_de_recoleccion.dart';

part 'ruta_punto.g.dart';

@JsonSerializable()
class RutaPunto {
  @JsonKey(name: '_id')
  int id;
  int orden;
  PuntoRecoleccion punto;

  RutaPunto(this.id, this.orden, this.punto);

  factory RutaPunto.fromJson(Map<String, dynamic> json) =>
      _$RutaPuntoFromJson(json);

  Map<String, dynamic> toJson() => _$RutaPuntoToJson(this);
}
