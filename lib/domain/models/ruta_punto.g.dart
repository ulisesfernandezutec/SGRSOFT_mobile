// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruta_punto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RutaPunto _$RutaPuntoFromJson(Map<String, dynamic> json) => RutaPunto(
      id: json['_id'] as int?,
      punto: PuntoMapa.fromJson(json['punto'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : GoogleDuration.fromJson(json['duration'] as Map<String, dynamic>),
      distance: json['distance'] == null
          ? null
          : GoogleDistance.fromJson(json['distance'] as Map<String, dynamic>),
      estado: json['estado'] == null
          ? null
          : RutaPuntoEstado.fromJson(json['estado'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RutaPuntoToJson(RutaPunto instance) => <String, dynamic>{
      '_id': instance.id,
      'punto': instance.punto.toJson(),
      'duration': instance.duration?.toJson(),
      'distance': instance.distance?.toJson(),
      'estado': instance.estado?.toJson(),
    };
