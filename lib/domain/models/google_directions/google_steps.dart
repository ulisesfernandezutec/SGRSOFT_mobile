import 'package:json_annotation/json_annotation.dart';

import 'google_distance.dart';
import 'google_duration.dart';
import 'google_location.dart';
import 'google_polyline.dart';

part 'google_steps.g.dart';

@JsonSerializable()
class GoogleStep {
  GoogleDistance? distance;
  GoogleDuration? duration;
  @JsonKey(name: 'end_location')
  GoogleLocation? endLocation;
  @JsonKey(name: 'html_instructions')
  String? htmlInstructions;
  GooglePolyline? polyline;
  @JsonKey(name: 'start_location')
  GoogleLocation? startLocation;
  @JsonKey(name: 'travel_mode')
  String? travelMode;
  String? maneuver;

  GoogleStep(
      {this.distance,
      this.duration,
      this.endLocation,
      this.htmlInstructions,
      this.polyline,
      this.startLocation,
      this.travelMode,
      this.maneuver});

  factory GoogleStep.fromJson(Map<String, dynamic> json) =>
      _$GoogleStepFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleStepToJson(this);
}
