import 'package:json_annotation/json_annotation.dart';

part 'tipo_de_residuo.g.dart';

@JsonSerializable()
class TipoDeResiduo {
  @JsonKey(name: '_id')
  int id;
  String nombre;

  TipoDeResiduo(this.id, this.nombre);

  factory TipoDeResiduo.fromJson(Map<String, dynamic> json) =>
      _$TipoDeResiduoFromJson(json);

  Map<String, dynamic> toJson() => _$TipoDeResiduoToJson(this);
}
