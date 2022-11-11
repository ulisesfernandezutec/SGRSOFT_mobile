// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ruta _$RutaFromJson(Map<String, dynamic> json) => Ruta(
      json['_id'] as int,
      json['nombre'] as String,
      Vehiculo.fromJson(json['vehiculo'] as Map<String, dynamic>),
      Usuario.fromJson(json['chofer'] as Map<String, dynamic>),
      Usuario.fromJson(json['administrador'] as Map<String, dynamic>),
      RutaPunto.fromJson(json['puntos'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RutaToJson(Ruta instance) => <String, dynamic>{
      '_id': instance.id,
      'nombre': instance.nombre,
      'vehiculo': instance.vehiculo,
      'chofer': instance.chofer,
      'administrador': instance.administrador,
      'puntos': instance.puntos,
    };
