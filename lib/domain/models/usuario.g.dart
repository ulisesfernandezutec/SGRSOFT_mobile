// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario(
      json['_id'] as int,
      json['usuario'] as String,
      json['contraseña'] as String,
      Rol.fromJson(json['rol'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      '_id': instance.id,
      'usuario': instance.username,
      'contraseña': instance.password,
      'rol': instance.rol,
    };
