import 'package:json_annotation/json_annotation.dart';

part 'google_geocoded_waypoint.g.dart';

@JsonSerializable()
class GoogleGeocodedWaypoint {
  @JsonKey(name: 'geocoder_status')
  String? geocoderStatus;
  @JsonKey(name: 'partial_match')
  bool? partialMatch;
  @JsonKey(name: 'place_id')
  String? placeId;
  List<String>? types;

  GoogleGeocodedWaypoint(
      {this.geocoderStatus, this.partialMatch, this.placeId, this.types});

  factory GoogleGeocodedWaypoint.fromJson(Map<String, dynamic> json) =>
      _$GoogleGeocodedWaypointFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleGeocodedWaypointToJson(this);
}
