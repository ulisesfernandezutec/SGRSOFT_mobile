// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_bound.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleBound _$GoogleBoundFromJson(Map<String, dynamic> json) => GoogleBound(
      northeast: json['northeast'] == null
          ? null
          : GoogleLocation.fromJson(json['northeast'] as Map<String, dynamic>),
      southwest: json['southwest'] == null
          ? null
          : GoogleLocation.fromJson(json['southwest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GoogleBoundToJson(GoogleBound instance) =>
    <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };
