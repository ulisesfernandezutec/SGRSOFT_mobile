import 'package:json_annotation/json_annotation.dart';

part 'azure_points.g.dart';

@JsonSerializable()
class AzurePoints {
  double latitude;
  double longitude;

  AzurePoints({required this.latitude, required this.longitude});

  factory AzurePoints.fromJson(Map<String, dynamic> json) =>
      _$AzurePointsFromJson(json);

  Map<String, dynamic> toJson() => _$AzurePointsToJson(this);
}
