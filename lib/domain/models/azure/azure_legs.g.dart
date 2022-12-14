// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azure_legs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AzureLegs _$AzureLegsFromJson(Map<String, dynamic> json) => AzureLegs(
      summary: AzureSummary.fromJson(json['summary'] as Map<String, dynamic>),
      points: (json['points'] as List<dynamic>)
          .map((e) => AzurePoints.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AzureLegsToJson(AzureLegs instance) => <String, dynamic>{
      'summary': instance.summary,
      'points': instance.points,
    };
