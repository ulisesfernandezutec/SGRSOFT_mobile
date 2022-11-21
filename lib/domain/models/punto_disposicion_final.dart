import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/punto_mapa.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';

part 'punto_disposicion_final.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class PuntoDisposicionFinal extends PuntoMapa {
  final List<TipoDeResiduo> tipos;

  PuntoDisposicionFinal(
      {required super.id,
      required super.latitud,
      required super.longitud,
      required super.direccion,
      required super.descripcion,
      super.enRuta,
      required this.tipos});

  factory PuntoDisposicionFinal.fromJson(Map<String, dynamic> json) =>
      _$PuntoDisposicionFinalFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PuntoDisposicionFinalToJson(this);
}
