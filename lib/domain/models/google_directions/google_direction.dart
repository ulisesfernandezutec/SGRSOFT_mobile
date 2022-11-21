import 'package:json_annotation/json_annotation.dart';
import 'google_geocoded_waypoint.dart';
import 'google_route.dart';

part 'google_direction.g.dart';

@JsonSerializable()
class GoogleDirection {
  @JsonKey(name: 'geocoded_waypoints')
  List<GoogleGeocodedWaypoint>? geocodedWaypoints;
  List<GoogleRoute> routes;
  String? status;

  GoogleDirection({this.geocodedWaypoints, required this.routes, this.status});

  factory GoogleDirection.fromJson(Map<String, dynamic> json) =>
      _$GoogleDirectionFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleDirectionToJson(this);
}
