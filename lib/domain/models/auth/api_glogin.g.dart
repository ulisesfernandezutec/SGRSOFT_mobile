// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_glogin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiGLogin _$ApiGLoginFromJson(Map<String, dynamic> json) => ApiGLogin(
      scope: json['scope'] as String?,
      azp: json['azp'] as String?,
      aud: json['aud'] as String?,
      sub: json['sub'] as String?,
      email: json['email'] as String?,
      emailVerified: json['emailVerified'] as String?,
      exp: json['exp'] as String?,
      expiresIn: json['expiresIn'] as String?,
      accessType: json['accessType'] as String?,
      sgrToken: json['sgrToken'] as String,
      rol: Rol.fromJson(json['rol'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiGLoginToJson(ApiGLogin instance) => <String, dynamic>{
      'scope': instance.scope,
      'azp': instance.azp,
      'aud': instance.aud,
      'sub': instance.sub,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'exp': instance.exp,
      'expiresIn': instance.expiresIn,
      'accessType': instance.accessType,
      'sgrToken': instance.sgrToken,
      'rol': instance.rol.toJson(),
    };
