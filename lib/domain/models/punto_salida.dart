import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/punto_mapa.dart';

part 'punto_salida.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class PuntoSalida extends PuntoMapa {
  PuntoSalida({
    required super.id,
    required super.latitud,
    required super.longitud,
    required super.direccion,
    required super.descripcion,
    super.enRuta,
  });

  factory PuntoSalida.fromJson(Map<String, dynamic> json) =>
      _$PuntoSalidaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PuntoSalidaToJson(this);
}
