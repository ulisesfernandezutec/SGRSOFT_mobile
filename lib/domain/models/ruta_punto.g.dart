// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruta_punto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RutaPunto _$RutaPuntoFromJson(Map<String, dynamic> json) => RutaPunto(
      id: json['_id'] as int?,
      punto: PuntoMapa.fromJson(json['punto'] as Map<String, dynamic>),
      googleDuration: json['googleDuration'] == null
          ? null
          : GoogleDuration.fromJson(
              json['googleDuration'] as Map<String, dynamic>),
      googleDistance: json['googleDistance'] == null
          ? null
          : GoogleDistance.fromJson(
              json['googleDistance'] as Map<String, dynamic>),
      estado: json['estado'] == null
          ? null
          : RutaPuntoEstado.fromJson(json['estado'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RutaPuntoToJson(RutaPunto instance) => <String, dynamic>{
      '_id': instance.id,
      'punto': instance.punto,
      'googleDuration': instance.googleDuration,
      'googleDistance': instance.googleDistance,
      'estado': instance.estado,
    };
