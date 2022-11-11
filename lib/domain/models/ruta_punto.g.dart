// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruta_punto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RutaPunto _$RutaPuntoFromJson(Map<String, dynamic> json) => RutaPunto(
      id: json['_id'] as int?,
      orden: json['orden'] as int,
      punto: PuntoRecoleccion.fromJson(json['punto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RutaPuntoToJson(RutaPunto instance) => <String, dynamic>{
      '_id': instance.id,
      'orden': instance.orden,
      'punto': instance.punto,
    };
