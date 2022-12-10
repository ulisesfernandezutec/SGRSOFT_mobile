import 'package:json_annotation/json_annotation.dart';

part 'optimized_waypoint.g.dart';

@JsonSerializable()
class OptimizedWaypoint {
  int providedIndex;
  int optimizedIndex;

  OptimizedWaypoint(
      {required this.providedIndex, required this.optimizedIndex});

  factory OptimizedWaypoint.fromJson(Map<String, dynamic> json) =>
      _$OptimizedWaypointFromJson(json);

  Map<String, dynamic> toJson() => _$OptimizedWaypointToJson(this);
}
