// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punto_recoleccion_estado.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PuntoRecoleccionEstado _$PuntoRecoleccionEstadoFromJson(
        Map<String, dynamic> json) =>
    PuntoRecoleccionEstado(
      json['_id'] as int,
      DateTime.parse(json['fecha'] as String),
      json['usuario'] as int,
      json['estado'] as String,
      json['detalle'] as String,
    );

Map<String, dynamic> _$PuntoRecoleccionEstadoToJson(
        PuntoRecoleccionEstado instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fecha': instance.fecha.toIso8601String(),
      'usuario': instance.usuario,
      'estado': instance.estado,
      'detalle': instance.detalle,
    };
