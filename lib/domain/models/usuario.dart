import 'package:json_annotation/json_annotation.dart';

import 'rol.dart';

part 'usuario.g.dart';

@JsonSerializable(explicitToJson: true)
class Usuario {
  @JsonKey(name: '_id')
  int? id;
  @JsonKey(name: "pwrd")
  String? password;
  Rol? rol;
  String? nombre;
  String? apellido;
  String? telefono;
  String? email;
  String? direccion;

  Usuario(
      {this.id,
      this.rol,
      this.nombre,
      this.apellido,
      this.telefono,
      this.email,
      this.direccion,
      this.password});

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}
