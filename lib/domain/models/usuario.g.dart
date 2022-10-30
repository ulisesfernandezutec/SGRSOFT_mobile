// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario(
      json['_id'] as int,
      json['usuario'] as String,
      json['apiId'] as String?,
      json['rol'] == null
          ? null
          : Rol.fromJson(json['rol'] as Map<String, dynamic>),
      json['nombre'] as String?,
      json['apellido'] as String?,
      json['documento'] as String?,
      json['telefono'] as String?,
      json['email'] as String?,
      json['direccion'] as String?,
    );

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      '_id': instance.id,
      'usuario': instance.username,
      'apiId': instance.apiId,
      'rol': instance.rol,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'documento': instance.documento,
      'telefono': instance.telefono,
      'email': instance.email,
      'direccion': instance.direccion,
    };
