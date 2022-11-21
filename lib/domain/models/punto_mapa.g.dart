// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punto_mapa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PuntoMapa _$PuntoMapaFromJson(Map<String, dynamic> json) => PuntoMapa(
      id: json['_id'] as int,
      latitud: (json['latitud'] as num).toDouble(),
      longitud: (json['longitud'] as num).toDouble(),
      direccion: json['direccion'] as String,
      descripcion: json['descripcion'] as String,
      enRuta: json['en_ruta'] as bool?,
    );

Map<String, dynamic> _$PuntoMapaToJson(PuntoMapa instance) => <String, dynamic>{
      '_id': instance.id,
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'direccion': instance.direccion,
      'descripcion': instance.descripcion,
      'en_ruta': instance.enRuta,
    };
