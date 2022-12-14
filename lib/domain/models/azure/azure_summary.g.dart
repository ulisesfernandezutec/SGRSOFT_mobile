// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azure_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AzureSummary _$AzureSummaryFromJson(Map<String, dynamic> json) => AzureSummary(
      lengthInMeters: json['lengthInMeters'] as int,
      travelTimeInSeconds: json['travelTimeInSeconds'] as int,
      trafficDelayInSeconds: json['trafficDelayInSeconds'] as int,
      trafficLengthInMeters: json['trafficLengthInMeters'] as int,
      departureTime: json['departureTime'] as String,
      arrivalTime: json['arrivalTime'] as String,
      noTrafficTravelTimeInSeconds: json['noTrafficTravelTimeInSeconds'] as int,
      historicTrafficTravelTimeInSeconds:
          json['historicTrafficTravelTimeInSeconds'] as int,
      liveTrafficIncidentsTravelTimeInSeconds:
          json['liveTrafficIncidentsTravelTimeInSeconds'] as int,
    );

Map<String, dynamic> _$AzureSummaryToJson(AzureSummary instance) =>
    <String, dynamic>{
      'lengthInMeters': instance.lengthInMeters,
      'travelTimeInSeconds': instance.travelTimeInSeconds,
      'trafficDelayInSeconds': instance.trafficDelayInSeconds,
      'trafficLengthInMeters': instance.trafficLengthInMeters,
      'departureTime': instance.departureTime,
      'arrivalTime': instance.arrivalTime,
      'noTrafficTravelTimeInSeconds': instance.noTrafficTravelTimeInSeconds,
      'historicTrafficTravelTimeInSeconds':
          instance.historicTrafficTravelTimeInSeconds,
      'liveTrafficIncidentsTravelTimeInSeconds':
          instance.liveTrafficIncidentsTravelTimeInSeconds,
    };
