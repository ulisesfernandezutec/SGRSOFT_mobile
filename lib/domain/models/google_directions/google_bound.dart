import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'google_location.dart';

part 'google_bound.g.dart';

@JsonSerializable()
class GoogleBound {
  GoogleLocation? northeast;
  GoogleLocation? southwest;

  GoogleBound({this.northeast, this.southwest});

  get northeastLatLng => LatLng(northeast?.lat ?? 0.0, northeast?.lng ?? 0.0);
  get southwestLatLng => LatLng(southwest?.lat ?? 0.0, southwest?.lng ?? 0.0);

  factory GoogleBound.fromJson(Map<String, dynamic> json) =>
      _$GoogleBoundFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleBoundToJson(this);
}
