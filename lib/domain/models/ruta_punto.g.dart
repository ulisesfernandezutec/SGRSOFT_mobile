// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruta_punto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RutaPunto _$RutaPuntoFromJson(Map<String, dynamic> json) => RutaPunto(
      id: json['_id'] as int?,
      punto: PuntoMapa.fromJson(json['punto'] as Map<String, dynamic>),
      distancia: (json['distancia'] as num).toDouble(),
      tiempoTrabajo: (json['tiempoTrabajo'] as num).toDouble(),
      tiempoTraslado: (json['tiempoTraslado'] as num).toDouble(),
      estado: json['estado'] as String,
    );

Map<String, dynamic> _$RutaPuntoToJson(RutaPunto instance) => <String, dynamic>{
      '_id': instance.id,
      'punto': instance.punto.toJson(),
      'distancia': instance.distancia,
      'tiempoTrabajo': instance.tiempoTrabajo,
      'tiempoTraslado': instance.tiempoTraslado,
      'estado': instance.estado,
    };
