// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleRoute _$GoogleRouteFromJson(Map<String, dynamic> json) => GoogleRoute(
      bounds: json['bounds'] == null
          ? null
          : GoogleBound.fromJson(json['bounds'] as Map<String, dynamic>),
      copyrights: json['copyrights'] as String?,
      legs: (json['legs'] as List<dynamic>)
          .map((e) => GoogleLeg.fromJson(e as Map<String, dynamic>))
          .toList(),
      overviewPolyline: json['overview_polyline'] == null
          ? null
          : GooglePolyline.fromJson(
              json['overview_polyline'] as Map<String, dynamic>),
      summary: json['summary'] as String?,
    );

Map<String, dynamic> _$GoogleRouteToJson(GoogleRoute instance) =>
    <String, dynamic>{
      'bounds': instance.bounds,
      'copyrights': instance.copyrights,
      'legs': instance.legs,
      'overview_polyline': instance.overviewPolyline,
      'summary': instance.summary,
    };
