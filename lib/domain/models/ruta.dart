import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/punto_disposicion_final.dart';
import 'package:sgrsoft/domain/models/punto_salida.dart';
import 'package:sgrsoft/domain/models/ruta_punto.dart';
import 'package:sgrsoft/domain/models/usuario.dart';
import 'package:sgrsoft/domain/models/vehiculo.dart';

import 'google_directions/google_bound.dart';

part 'ruta.g.dart';

@JsonSerializable()
// ignore: must_be_immutable
class Ruta extends Equatable {
  @JsonKey(name: '_id')
  int? id;
  String? nombre;
  Vehiculo? vehiculo;
  Usuario? chofer;
  Usuario? administrador;
  GoogleBound? bound;
  List<RutaPunto> puntos = [];
  PuntoSalida? salida;
  PuntoDisposicionFinal? disposicionFinal;

  Ruta(
      {this.id,
      this.nombre,
      this.vehiculo,
      this.chofer,
      this.administrador,
      required this.puntos,
      this.bound,
      this.salida,
      this.disposicionFinal});

  factory Ruta.fromJson(Map<String, dynamic> json) => _$RutaFromJson(json);

  Map<String, dynamic> toJson() => _$RutaToJson(this);

  @override
  List<Object?> get props =>
      [id, nombre, vehiculo, chofer, administrador, puntos, bound];
}
