// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruta_punto_estado.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RutaPuntoEstado _$RutaPuntoEstadoFromJson(Map<String, dynamic> json) =>
    RutaPuntoEstado(
      id: json['_id'] as int?,
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
    );

Map<String, dynamic> _$RutaPuntoEstadoToJson(RutaPuntoEstado instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'nombre': instance.nombre,
      'descripcion': instance.descripcion,
    };
