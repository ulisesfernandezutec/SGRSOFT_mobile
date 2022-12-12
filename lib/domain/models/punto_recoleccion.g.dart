// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punto_recoleccion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PuntoRecoleccion _$PuntoRecoleccionFromJson(Map<String, dynamic> json) =>
    PuntoRecoleccion(
      id: json['_id'] as int,
      latitud: (json['latitud'] as num).toDouble(),
      longitud: (json['longitud'] as num).toDouble(),
      direccion: json['direccion'] as String,
      descripcion: json['descripcion'] as String,
      enRuta: json['en_ruta'] as bool?,
      usuario: json['usuario'] as int,
      tipo: TipoDeResiduo.fromJson(json['tipo'] as Map<String, dynamic>),
      estados: (json['estados'] as List<dynamic>?)
          ?.map(
              (e) => PuntoRecoleccionEstado.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PuntoRecoleccionToJson(PuntoRecoleccion instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'direccion': instance.direccion,
      'descripcion': instance.descripcion,
      'en_ruta': instance.enRuta,
      'tipo': instance.tipo.toJson(),
      'usuario': instance.usuario,
      'estados': instance.estados?.map((e) => e.toJson()).toList(),
    };
