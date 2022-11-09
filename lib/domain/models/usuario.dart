import 'package:json_annotation/json_annotation.dart';

import 'rol.dart';

part 'usuario.g.dart';

@JsonSerializable()
class Usuario {
  @JsonKey(name: '_id')
  int? id;
  String? username;
  String? apiId;
  Rol? rol;
  String? nombre;
  String? apellido;
  String? documento;
  String? telefono;
  String? email;
  String? direccion;

  Usuario(
      {this.id,
      this.username,
      this.apiId,
      this.rol,
      this.nombre,
      this.apellido,
      this.documento,
      this.telefono,
      this.email,
      this.direccion});

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}
