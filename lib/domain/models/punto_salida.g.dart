// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punto_salida.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PuntoSalida _$PuntoSalidaFromJson(Map<String, dynamic> json) => PuntoSalida(
      id: json['_id'] as int,
      latitud: (json['latitud'] as num).toDouble(),
      longitud: (json['longitud'] as num).toDouble(),
      direccion: json['direccion'] as String,
      descripcion: json['descripcion'] as String,
      enRuta: json['en_ruta'] as bool?,
      nombre: json['nombre'] as String,
    );

Map<String, dynamic> _$PuntoSalidaToJson(PuntoSalida instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'direccion': instance.direccion,
      'descripcion': instance.descripcion,
      'en_ruta': instance.enRuta,
      'nombre': instance.nombre,
    };
