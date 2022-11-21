import 'package:json_annotation/json_annotation.dart';

import 'google_duration.dart';
import 'google_distance.dart';
import 'google_steps.dart';

part 'google_leg.g.dart';

@JsonSerializable()
class GoogleLeg {
  GoogleDistance? distance;
  GoogleDuration? duration;
  @JsonKey(name: 'end_address')
  String? endAddress;
  @JsonKey(name: 'end_location')
  GoogleLeg? endLocation;
  @JsonKey(name: 'start_address')
  String? startAddress;
  @JsonKey(name: 'start_location')
  GoogleLeg? startLocation;
  List<GoogleStep>? steps;
  // List<Null>? trafficSpeedEntry;
  // List<Null>? viaWaypoint;

  GoogleLeg(
      {this.distance,
      this.duration,
      this.endAddress,
      this.endLocation,
      this.startAddress,
      this.startLocation,
      this.steps});

  // this.trafficSpeedEntry,
  // this.viaWaypoint

  // if (this.trafficSpeedEntry != null) {
  //   data['traffic_speed_entry'] =
  //       this.trafficSpeedEntry!.map((v) => v.toJson()).toList();
  // }
  // if (this.viaWaypoint != null) {
  //   data['via_waypoint'] = this.viaWaypoint!.map((v) => v.toJson()).toList();
  // }

  factory GoogleLeg.fromJson(Map<String, dynamic> json) =>
      _$GoogleLegFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleLegToJson(this);
}
