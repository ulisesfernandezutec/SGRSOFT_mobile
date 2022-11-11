// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario(
      id: json['_id'] as int?,
      username: json['username'] as String?,
      apiId: json['apiId'] as String?,
      rol: json['rol'] == null
          ? null
          : Rol.fromJson(json['rol'] as Map<String, dynamic>),
      nombre: json['nombre'] as String?,
      apellido: json['apellido'] as String?,
      documento: json['documento'] as String?,
      telefono: json['telefono'] as String?,
      email: json['email'] as String?,
      direccion: json['direccion'] as String?,
    );

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'apiId': instance.apiId,
      'rol': instance.rol,
      'nombre': instance.nombre,
      'apellido': instance.apellido,
      'documento': instance.documento,
      'telefono': instance.telefono,
      'email': instance.email,
      'direccion': instance.direccion,
    };
