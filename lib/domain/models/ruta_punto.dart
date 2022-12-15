import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/punto_mapa.dart';

part 'ruta_punto.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class RutaPunto extends Equatable {
  @JsonKey(name: '_id')
  int? id;
  final PuntoMapa punto;
  double distancia;
  double tiempoTrabajo;
  double tiempoTraslado;
  String estado;

  RutaPunto(
      {this.id,
      required this.punto,
      required this.distancia,
      required this.tiempoTrabajo,
      required this.tiempoTraslado,
      required this.estado});

  factory RutaPunto.fromJson(Map<String, dynamic> json) =>
      _$RutaPuntoFromJson(json);

  Map<String, dynamic> toJson() => _$RutaPuntoToJson(this);

  @override
  List<Object?> get props =>
      [id, punto, distancia, tiempoTrabajo, tiempoTraslado, estado];
}
