// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehiculo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehiculo _$VehiculoFromJson(Map<String, dynamic> json) => Vehiculo(
      id: json['_id'] as int?,
      nombre: json['nombre'] as String?,
      matricula: json['matricula'] as String?,
      marca: json['marca'] as String?,
      modelo: json['modelo'] as String?,
      chofer: json['chofer'] as int?,
      totalkilometros: json['totalkilometros'] as String?,
      totalrutas: json['totalrutas'] as String?,
      totaltiempotrabajo: json['totaltiempotrabajo'] as String?,
    );

Map<String, dynamic> _$VehiculoToJson(Vehiculo instance) => <String, dynamic>{
      '_id': instance.id,
      'nombre': instance.nombre,
      'matricula': instance.matricula,
      'marca': instance.marca,
      'modelo': instance.modelo,
      'chofer': instance.chofer,
      'totalkilometros': instance.totalkilometros,
      'totalrutas': instance.totalrutas,
      'totaltiempotrabajo': instance.totaltiempotrabajo,
    };
