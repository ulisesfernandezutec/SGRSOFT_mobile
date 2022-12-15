import 'package:json_annotation/json_annotation.dart';

part 'vehiculo.g.dart';

@JsonSerializable()
class Vehiculo {
  @JsonKey(name: '_id')
  int? id;
  String? nombre;
  String? matricula;
  String? marca;
  String? modelo;
  int? chofer;
  String? totalkilometros;
  String? totalrutas;
  String? totaltiempotrabajo;

  Vehiculo(
      {this.id,
      this.nombre,
      this.matricula,
      this.marca,
      this.modelo,
      this.chofer,
      this.totalkilometros,
      this.totalrutas,
      this.totaltiempotrabajo});

  factory Vehiculo.fromJson(Map<String, dynamic> json) =>
      _$VehiculoFromJson(json);

  Map<String, dynamic> toJson() => _$VehiculoToJson(this);
}
