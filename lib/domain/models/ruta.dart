import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/ruta_punto.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';

part 'ruta.g.dart';

@JsonSerializable()
class Ruta {
  @JsonKey(name: '_id')
  int id;
  String nombre;
  Vehiculo vehiculo;
  Usuario chofer;
  Usuario administrador;
  RutaPunto puntos;

  Ruta(this.id, this.nombre, this.vehiculo, this.chofer, this.administrador,
      this.puntos);

  factory Ruta.fromJson(Map<String, dynamic> json) => _$RutaFromJson(json);

  Map<String, dynamic> toJson() => _$RutaToJson(this);
}
