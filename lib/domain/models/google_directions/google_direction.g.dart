// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_direction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleDirection _$GoogleDirectionFromJson(Map<String, dynamic> json) =>
    GoogleDirection(
      geocodedWaypoints: (json['geocoded_waypoints'] as List<dynamic>?)
          ?.map(
              (e) => GoogleGeocodedWaypoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      routes: (json['routes'] as List<dynamic>)
          .map((e) => GoogleRoute.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$GoogleDirectionToJson(GoogleDirection instance) =>
    <String, dynamic>{
      'geocoded_waypoints': instance.geocodedWaypoints,
      'routes': instance.routes,
      'status': instance.status,
    };
