import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/punto_recoleccion_estado.dart';
import 'package:sgrsoft/domain/models/punto_mapa.dart';
import 'package:sgrsoft/domain/models/tipo_residuo.dart';

part 'punto_recoleccion.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class PuntoRecoleccion extends PuntoMapa {
  final TipoDeResiduo tipo;
  @JsonKey(name: 'usuario')
  final int usuario;
  List<PuntoRecoleccionEstado>? estados;

  PuntoRecoleccion({
    required super.id,
    required super.latitud,
    required super.longitud,
    required super.direccion,
    required super.descripcion,
    super.enRuta,
    required this.usuario,
    required this.tipo,
    this.estados,
  });

  factory PuntoRecoleccion.fromJson(Map<String, dynamic> json) =>
      _$PuntoRecoleccionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PuntoRecoleccionToJson(this);
}
