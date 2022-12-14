import 'package:json_annotation/json_annotation.dart';

part 'azure_sections.g.dart';

@JsonSerializable()
class AzureSections {
  int startPointIndex;
  int endPointIndex;
  String sectionType;
  String travelMode;

  AzureSections(
      {required this.startPointIndex,
      required this.endPointIndex,
      required this.sectionType,
      required this.travelMode});

  factory AzureSections.fromJson(Map<String, dynamic> json) =>
      _$AzureSectionsFromJson(json);

  Map<String, dynamic> toJson() => _$AzureSectionsToJson(this);
}
