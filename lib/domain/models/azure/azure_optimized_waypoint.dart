import 'package:json_annotation/json_annotation.dart';

part 'azure_optimized_waypoint.g.dart';

@JsonSerializable()
class AzureOptimizedWaypoint {
  int providedIndex;
  int optimizedIndex;

  AzureOptimizedWaypoint(
      {required this.providedIndex, required this.optimizedIndex});

  factory AzureOptimizedWaypoint.fromJson(Map<String, dynamic> json) =>
      _$AzureOptimizedWaypointFromJson(json);

  Map<String, dynamic> toJson() => _$AzureOptimizedWaypointToJson(this);
}
