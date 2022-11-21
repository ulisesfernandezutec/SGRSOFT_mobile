import 'package:json_annotation/json_annotation.dart';
import 'google_bound.dart';
import 'google_leg.dart';
import 'google_polyline.dart';

part 'google_route.g.dart';

@JsonSerializable()
class GoogleRoute {
  GoogleBound? bounds;
  String? copyrights;
  List<GoogleLeg> legs;
  @JsonKey(name: 'overview_polyline')
  GooglePolyline? overviewPolyline;
  String? summary;
  // List<Null>? warnings;
  // List<int>? waypointOrder;

  GoogleRoute(
      {this.bounds,
      this.copyrights,
      required this.legs,
      this.overviewPolyline,
      this.summary});
  // this.warnings,
  // this.waypointOrder

  factory GoogleRoute.fromJson(Map<String, dynamic> json) =>
      _$GoogleRouteFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleRouteToJson(this);
}
