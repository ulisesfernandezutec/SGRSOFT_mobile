// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azure_routes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AzureRoutes _$AzureRoutesFromJson(Map<String, dynamic> json) => AzureRoutes(
      summary: AzureSummary.fromJson(json['summary'] as Map<String, dynamic>),
      legs: (json['legs'] as List<dynamic>)
          .map((e) => AzureLegs.fromJson(e as Map<String, dynamic>))
          .toList(),
      sections: (json['sections'] as List<dynamic>)
          .map((e) => AzureSections.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AzureRoutesToJson(AzureRoutes instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'legs': instance.legs,
      'sections': instance.sections,
    };
