// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_leg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleLeg _$GoogleLegFromJson(Map<String, dynamic> json) => GoogleLeg(
      distance: json['distance'] == null
          ? null
          : GoogleDistance.fromJson(json['distance'] as Map<String, dynamic>),
      duration: json['duration'] == null
          ? null
          : GoogleDuration.fromJson(json['duration'] as Map<String, dynamic>),
      endAddress: json['end_address'] as String?,
      endLocation: json['end_location'] == null
          ? null
          : GoogleLeg.fromJson(json['end_location'] as Map<String, dynamic>),
      startAddress: json['start_address'] as String?,
      startLocation: json['start_location'] == null
          ? null
          : GoogleLeg.fromJson(json['start_location'] as Map<String, dynamic>),
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => GoogleStep.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GoogleLegToJson(GoogleLeg instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'end_address': instance.endAddress,
      'end_location': instance.endLocation,
      'start_address': instance.startAddress,
      'start_location': instance.startLocation,
      'steps': instance.steps,
    };
