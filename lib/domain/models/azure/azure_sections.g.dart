// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azure_sections.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AzureSections _$AzureSectionsFromJson(Map<String, dynamic> json) =>
    AzureSections(
      startPointIndex: json['startPointIndex'] as int,
      endPointIndex: json['endPointIndex'] as int,
      sectionType: json['sectionType'] as String,
      travelMode: json['travelMode'] as String,
    );

Map<String, dynamic> _$AzureSectionsToJson(AzureSections instance) =>
    <String, dynamic>{
      'startPointIndex': instance.startPointIndex,
      'endPointIndex': instance.endPointIndex,
      'sectionType': instance.sectionType,
      'travelMode': instance.travelMode,
    };
