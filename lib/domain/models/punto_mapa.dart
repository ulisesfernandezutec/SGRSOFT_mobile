import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'punto_mapa.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class PuntoMapa extends Equatable {
  @JsonKey(name: '_id')
  int id;
  final double latitud;
  final double longitud;
  final String direccion;
  final String descripcion;
  @JsonKey(name: 'en_ruta')
  bool? enRuta = false;

  PuntoMapa(
      {required this.id,
      required this.latitud,
      required this.longitud,
      required this.direccion,
      required this.descripcion,
      this.enRuta});

  factory PuntoMapa.fromJson(Map<String, dynamic> json) =>
      _$PuntoMapaFromJson(json);

  Map<String, dynamic> toJson() => _$PuntoMapaToJson(this);

  @override
  List<Object?> get props => [id, latitud, longitud, direccion];
}
