import 'package:json_annotation/json_annotation.dart';

part 'rol.g.dart';

@JsonSerializable()
class Rol {
  @JsonKey(name: '_id')
  int id;
  String nombre;

  Rol(this.id, this.nombre);

  factory Rol.fromJson(Map<String, dynamic> json) => _$RolFromJson(json);

  Map<String, dynamic> toJson() => _$RolToJson(this);
}
