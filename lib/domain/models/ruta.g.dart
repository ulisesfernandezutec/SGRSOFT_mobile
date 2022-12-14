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
      puntos: (json['puntos'] as List<dynamic>?)
          ?.map((e) => RutaPunto.fromJson(e as Map<String, dynamic>))
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
      fecha: json['fecha'] as int?,
      optimizar: json['optimizar'] as bool,
      estado: json['estado'] as String,
      distancia: (json['distancia'] as num).toDouble(),
      tiempoTrabajo: (json['tiempoTrabajo'] as num).toDouble(),
      tiempoTraslado: (json['tiempoTraslado'] as num).toDouble(),
    );

Map<String, dynamic> _$RutaToJson(Ruta instance) => <String, dynamic>{
      '_id': instance.id,
      'nombre': instance.nombre,
      'vehiculo': instance.vehiculo?.toJson(),
      'chofer': instance.chofer?.toJson(),
      'administrador': instance.administrador?.toJson(),
      'bound': instance.bound?.toJson(),
      'puntos': instance.puntos?.map((e) => e.toJson()).toList(),
      'salida': instance.salida?.toJson(),
      'disposicionFinal': instance.disposicionFinal?.toJson(),
      'fecha': instance.fecha,
      'estado': instance.estado,
      'optimizar': instance.optimizar,
      'distancia': instance.distancia,
      'tiempoTrabajo': instance.tiempoTrabajo,
      'tiempoTraslado': instance.tiempoTraslado,
    };
