import 'package:json_annotation/json_annotation.dart';

part 'google_location.g.dart';

@JsonSerializable()
class GoogleLocation {
  double? lat;
  double? lng;

  GoogleLocation({this.lat, this.lng});

  factory GoogleLocation.fromJson(Map<String, dynamic> json) =>
      _$GoogleLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleLocationToJson(this);
}
