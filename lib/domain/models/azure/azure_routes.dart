import 'package:json_annotation/json_annotation.dart';

import 'azure_legs.dart';
import 'azure_sections.dart';
import 'azure_summary.dart';

part 'azure_routes.g.dart';

@JsonSerializable()
class AzureRoutes {
  AzureSummary summary;
  List<AzureLegs> legs;
  List<AzureSections> sections;

  AzureRoutes(
      {required this.summary, required this.legs, required this.sections});

  factory AzureRoutes.fromJson(Map<String, dynamic> json) =>
      _$AzureRoutesFromJson(json);

  Map<String, dynamic> toJson() => _$AzureRoutesToJson(this);
}
