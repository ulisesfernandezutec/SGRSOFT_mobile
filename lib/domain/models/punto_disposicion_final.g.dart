// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punto_disposicion_final.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PuntoDisposicionFinal _$PuntoDisposicionFinalFromJson(
        Map<String, dynamic> json) =>
    PuntoDisposicionFinal(
      id: json['_id'] as int,
      latitud: (json['latitud'] as num).toDouble(),
      longitud: (json['longitud'] as num).toDouble(),
      direccion: json['direccion'] as String,
      descripcion: json['descripcion'] as String,
      enRuta: json['en_ruta'] as bool?,
      tipos: (json['tipos'] as List<dynamic>)
          .map((e) => TipoDeResiduo.fromJson(e as Map<String, dynamic>))
          .toList(),
      nombre: json['nombre'] as String,
    );

Map<String, dynamic> _$PuntoDisposicionFinalToJson(
        PuntoDisposicionFinal instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'direccion': instance.direccion,
      'descripcion': instance.descripcion,
      'en_ruta': instance.enRuta,
      'tipos': instance.tipos,
      'nombre': instance.nombre,
    };
