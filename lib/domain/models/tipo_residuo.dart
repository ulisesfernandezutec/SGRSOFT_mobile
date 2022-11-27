import 'package:json_annotation/json_annotation.dart';

part 'tipo_residuo.g.dart';

@JsonSerializable()
class TipoDeResiduo {
  @JsonKey(name: '_id')
  int id;
  String nombre;

  TipoDeResiduo({required this.id, required this.nombre});

  factory TipoDeResiduo.fromJson(Map<String, dynamic> json) =>
      _$TipoDeResiduoFromJson(json);

  Map<String, dynamic> toJson() => _$TipoDeResiduoToJson(this);
}
