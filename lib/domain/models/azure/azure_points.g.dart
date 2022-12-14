// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azure_points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AzurePoints _$AzurePointsFromJson(Map<String, dynamic> json) => AzurePoints(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$AzurePointsToJson(AzurePoints instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
