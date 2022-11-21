// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_geocoded_waypoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleGeocodedWaypoint _$GoogleGeocodedWaypointFromJson(
        Map<String, dynamic> json) =>
    GoogleGeocodedWaypoint(
      geocoderStatus: json['geocoder_status'] as String?,
      partialMatch: json['partial_match'] as bool?,
      placeId: json['place_id'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$GoogleGeocodedWaypointToJson(
        GoogleGeocodedWaypoint instance) =>
    <String, dynamic>{
      'geocoder_status': instance.geocoderStatus,
      'partial_match': instance.partialMatch,
      'place_id': instance.placeId,
      'types': instance.types,
    };
