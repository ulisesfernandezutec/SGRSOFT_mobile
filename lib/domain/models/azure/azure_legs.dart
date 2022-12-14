import 'package:json_annotation/json_annotation.dart';

import 'azure_points.dart';
import 'azure_summary.dart';

part 'azure_legs.g.dart';

@JsonSerializable()
class AzureLegs {
  AzureSummary summary;
  List<AzurePoints> points;

  AzureLegs({required this.summary, required this.points});

  factory AzureLegs.fromJson(Map<String, dynamic> json) =>
      _$AzureLegsFromJson(json);

  Map<String, dynamic> toJson() => _$AzureLegsToJson(this);
}
