// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punto_de_recoleccion_estado.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PuntoRecoleccionEstadoAdapter
    extends TypeAdapter<PuntoRecoleccionEstado> {
  @override
  final int typeId = 0;

  @override
  PuntoRecoleccionEstado read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PuntoRecoleccionEstado(
      fields[0] as int,
      fields[1] as DateTime,
      fields[2] as int,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PuntoRecoleccionEstado obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fecha)
      ..writeByte(2)
      ..write(obj.usuario)
      ..writeByte(3)
      ..write(obj.estado)
      ..writeByte(4)
      ..write(obj.detalle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PuntoRecoleccionEstadoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PuntoRecoleccionEstado _$PuntoRecoleccionEstadoFromJson(
        Map<String, dynamic> json) =>
    PuntoRecoleccionEstado(
      json['_id'] as int,
      DateTime.parse(json['fecha'] as String),
      json['usuario'] as int,
      json['estado'] as String,
      json['detalle'] as String,
    );

Map<String, dynamic> _$PuntoRecoleccionEstadoToJson(
        PuntoRecoleccionEstado instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fecha': instance.fecha.toIso8601String(),
      'usuario': instance.usuario,
      'estado': instance.estado,
      'detalle': instance.detalle,
    };
