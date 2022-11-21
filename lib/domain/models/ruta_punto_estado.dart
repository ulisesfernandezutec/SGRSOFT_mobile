import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ruta_punto_estado.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class RutaPuntoEstado extends Equatable {
  @JsonKey(name: '_id')
  int? id;
  final String nombre;
  final String descripcion;

  RutaPuntoEstado({this.id, required this.nombre, required this.descripcion});

  factory RutaPuntoEstado.fromJson(Map<String, dynamic> json) =>
      _$RutaPuntoEstadoFromJson(json);

  Map<String, dynamic> toJson() => _$RutaPuntoEstadoToJson(this);

  @override
  List<Object?> get props => [id, nombre, descripcion];
}
