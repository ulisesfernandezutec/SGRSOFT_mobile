import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/google_directions/google_distance.dart';
import 'package:sgrsoft/domain/models/google_directions/google_duration.dart';
import 'package:sgrsoft/domain/models/punto_mapa.dart';
import 'package:sgrsoft/domain/models/ruta_punto_estado.dart';

part 'ruta_punto.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class RutaPunto extends Equatable {
  @JsonKey(name: '_id')
  int? id;
  final PuntoMapa punto;
  GoogleDuration? googleDuration;
  GoogleDistance? googleDistance;
  RutaPuntoEstado? estado;

  RutaPunto(
      {this.id,
      required this.punto,
      this.googleDuration,
      this.googleDistance,
      this.estado});

  factory RutaPunto.fromJson(Map<String, dynamic> json) =>
      _$RutaPuntoFromJson(json);

  Map<String, dynamic> toJson() => _$RutaPuntoToJson(this);

  @override
  List<Object?> get props => [id, punto, googleDistance, googleDuration];
}
