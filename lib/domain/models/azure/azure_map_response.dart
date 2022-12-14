import 'package:json_annotation/json_annotation.dart';

import 'azure_optimized_waypoint.dart';
import 'azure_routes.dart';

part 'azure_map_response.g.dart';

@JsonSerializable()
class AzureMapResponse {
  String formatVersion;
  List<AzureRoutes> routes;
  List<AzureOptimizedWaypoint>? optimizedWaypoints;

  AzureMapResponse(
      {required this.formatVersion,
      required this.routes,
      this.optimizedWaypoints});

  factory AzureMapResponse.fromJson(Map<String, dynamic> json) =>
      _$AzureMapResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AzureMapResponseToJson(this);
}
