// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azure_map_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AzureMapResponse _$AzureMapResponseFromJson(Map<String, dynamic> json) =>
    AzureMapResponse(
      formatVersion: json['formatVersion'] as String,
      routes: (json['routes'] as List<dynamic>)
          .map((e) => AzureRoutes.fromJson(e as Map<String, dynamic>))
          .toList(),
      optimizedWaypoints: (json['optimizedWaypoints'] as List<dynamic>?)
          ?.map(
              (e) => AzureOptimizedWaypoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AzureMapResponseToJson(AzureMapResponse instance) =>
    <String, dynamic>{
      'formatVersion': instance.formatVersion,
      'routes': instance.routes,
      'optimizedWaypoints': instance.optimizedWaypoints,
    };
