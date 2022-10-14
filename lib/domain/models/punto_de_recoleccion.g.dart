// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punto_de_recoleccion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PuntoRecoleccion _$PuntoRecoleccionFromJson(Map<String, dynamic> json) =>
    PuntoRecoleccion(
      json['_id'] as int,
      (json['latitud'] as num).toDouble(),
      (json['longitud'] as num).toDouble(),
      json['tipo'] as String,
      json['direccion'] as String,
      json['descripcion'] as String,
      PuntoRecoleccionEstado.fromJson(json['estado'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PuntoRecoleccionToJson(PuntoRecoleccion instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'tipo': instance.tipo,
      'direccion': instance.direccion,
      'descripcion': instance.descripcion,
      'estado': instance.estado,
    };
