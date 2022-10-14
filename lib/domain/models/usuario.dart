import 'package:json_annotation/json_annotation.dart';

import 'rol.dart';

part 'usuario.g.dart';

@JsonSerializable()
class Usuario {
  @JsonKey(name: '_id')
  int id;
  @JsonKey(name: 'usuario')
  String username;
  @JsonKey(name: 'contraseña')
  String password;
  Rol rol;
  Usuario(this.id, this.username, this.password, this.rol);

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}
