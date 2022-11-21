// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ruta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ruta _$RutaFromJson(Map<String, dynamic> json) => Ruta(
      id: json['_id'] as int?,
      nombre: json['nombre'] as String?,
      vehiculo: json['vehiculo'] == null
          ? null
          : Vehiculo.fromJson(json['vehiculo'] as Map<String, dynamic>),
      chofer: json['chofer'] == null
          ? null
          : Usuario.fromJson(json['chofer'] as Map<String, dynamic>),
      administrador: json['administrador'] == null
          ? null
          : Usuario.fromJson(json['administrador'] as Map<String, dynamic>),
      puntos: (json['puntos'] as List<dynamic>)
          .map((e) => RutaPunto.fromJson(e as Map<String, dynamic>))
          .toList(),
      bound: json['bound'] == null
          ? null
          : GoogleBound.fromJson(json['bound'] as Map<String, dynamic>),
      salida: json['salida'] == null
          ? null
          : PuntoSalida.fromJson(json['salida'] as Map<String, dynamic>),
      disposicionFinal: json['disposicionFinal'] == null
          ? null
          : PuntoDisposicionFinal.fromJson(
              json['disposicionFinal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RutaToJson(Ruta instance) => <String, dynamic>{
      '_id': instance.id,
      'nombre': instance.nombre,
      'vehiculo': instance.vehiculo,
      'chofer': instance.chofer,
      'administrador': instance.administrador,
      'bound': instance.bound,
      'puntos': instance.puntos,
      'salida': instance.salida,
      'disposicionFinal': instance.disposicionFinal,
    };
