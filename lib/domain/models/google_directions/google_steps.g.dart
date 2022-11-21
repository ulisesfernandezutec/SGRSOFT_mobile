// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_steps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleStep _$GoogleStepFromJson(Map<String, dynamic> json) => GoogleStep(
      distance: json['distance'] == null
          ? null
          : GoogleDistance.fromJson(json['distance'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : GoogleDuration.fromJson(json['duration'] as Map<String, dynamic>),
      endLocation: json['end_location'] == null
          ? null
          : GoogleLocation.fromJson(
              json['end_location'] as Map<String, dynamic>),
      htmlInstructions: json['html_instructions'] as String?,
      polyline: json['polyline'] == null
          ? null
          : GooglePolyline.fromJson(json['polyline'] as Map<String, dynamic>),
      startLocation: json['start_location'] == null
          ? null
          : GoogleLocation.fromJson(
              json['start_location'] as Map<String, dynamic>),
      travelMode: json['travel_mode'] as String?,
      maneuver: json['maneuver'] as String?,
    );

Map<String, dynamic> _$GoogleStepToJson(GoogleStep instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'end_location': instance.endLocation,
      'html_instructions': instance.htmlInstructions,
      'polyline': instance.polyline,
      'start_location': instance.startLocation,
      'travel_mode': instance.travelMode,
      'maneuver': instance.maneuver,
    };
