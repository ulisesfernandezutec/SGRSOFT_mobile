import 'package:json_annotation/json_annotation.dart';

part 'azure_summary.g.dart';

@JsonSerializable()
class AzureSummary {
  int lengthInMeters;
  int travelTimeInSeconds;
  int trafficDelayInSeconds;
  int trafficLengthInMeters;
  String departureTime;
  String arrivalTime;
  int noTrafficTravelTimeInSeconds;
  int historicTrafficTravelTimeInSeconds;
  int liveTrafficIncidentsTravelTimeInSeconds;

  AzureSummary(
      {required this.lengthInMeters,
      required this.travelTimeInSeconds,
      required this.trafficDelayInSeconds,
      required this.trafficLengthInMeters,
      required this.departureTime,
      required this.arrivalTime,
      required this.noTrafficTravelTimeInSeconds,
      required this.historicTrafficTravelTimeInSeconds,
      required this.liveTrafficIncidentsTravelTimeInSeconds});

  factory AzureSummary.fromJson(Map<String, dynamic> json) =>
      _$AzureSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$AzureSummaryToJson(this);
}
