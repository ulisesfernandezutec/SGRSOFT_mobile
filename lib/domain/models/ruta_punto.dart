import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/google_directions/google_distance.dart';
import 'package:sgrsoft/domain/models/google_directions/google_duration.dart';
import 'package:sgrsoft/domain/models/punto_mapa.dart';
import 'package:sgrsoft/domain/models/ruta_punto_estado.dart';

part 'ruta_punto.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class RutaPunto extends Equatable {
  @JsonKey(name: '_id')
  int? id;
  final PuntoMapa punto;
  GoogleDuration? duration;
  GoogleDistance? distance;
  RutaPuntoEstado? estado;

  RutaPunto(
      {this.id,
      required this.punto,
      this.duration,
      this.distance,
      this.estado});

  factory RutaPunto.fromJson(Map<String, dynamic> json) =>
      _$RutaPuntoFromJson(json);

  Map<String, dynamic> toJson() => _$RutaPuntoToJson(this);

  @override
  List<Object?> get props => [id, punto, distance, duration];
}
