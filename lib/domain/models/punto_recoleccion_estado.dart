import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'punto_recoleccion_estado.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class PuntoRecoleccionEstado extends Equatable {
  @JsonKey(name: '_id')
  int id;

  DateTime fecha;

  int usuario;

  String estado;

  String detalle;

  PuntoRecoleccionEstado(
      this.id, this.fecha, this.usuario, this.estado, this.detalle);

  factory PuntoRecoleccionEstado.fromJson(Map<String, dynamic> json) =>
      _$PuntoRecoleccionEstadoFromJson(json);

  Map<String, dynamic> toJson() => _$PuntoRecoleccionEstadoToJson(this);

  @override
  List<Object?> get props => [id];
}
