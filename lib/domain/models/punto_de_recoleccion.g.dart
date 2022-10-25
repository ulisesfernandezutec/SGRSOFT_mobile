// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punto_de_recoleccion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PuntoRecoleccionAdapter extends TypeAdapter<PuntoRecoleccion> {
  @override
  final int typeId = 1;

  @override
  PuntoRecoleccion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PuntoRecoleccion(
      fields[0] as int,
      fields[1] as double,
      fields[2] as double,
      fields[3] as TipoDeResiduo,
      fields[4] as String,
      fields[5] as String,
      (fields[6] as List?)?.cast<PuntoRecoleccionEstado>(),
    );
  }

  @override
  void write(BinaryWriter writer, PuntoRecoleccion obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.latitud)
      ..writeByte(2)
      ..write(obj.longitud)
      ..writeByte(3)
      ..write(obj.tipo)
      ..writeByte(4)
      ..write(obj.direccion)
      ..writeByte(5)
      ..write(obj.descripcion)
      ..writeByte(6)
      ..write(obj.estados);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PuntoRecoleccionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PuntoRecoleccion _$PuntoRecoleccionFromJson(Map<String, dynamic> json) =>
    PuntoRecoleccion(
      json['_id'] as int,
      (json['latitud'] as num).toDouble(),
      (json['longitud'] as num).toDouble(),
      TipoDeResiduo.fromJson(json['tipo'] as Map<String, dynamic>),
      json['direccion'] as String,
      json['descripcion'] as String,
      (json['estados'] as List<dynamic>?)
          ?.map(
              (e) => PuntoRecoleccionEstado.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PuntoRecoleccionToJson(PuntoRecoleccion instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'tipo': instance.tipo,
      'direccion': instance.direccion,
      'descripcion': instance.descripcion,
      'estados': instance.estados,
    };
