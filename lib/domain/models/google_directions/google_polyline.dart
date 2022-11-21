import 'package:json_annotation/json_annotation.dart';

part 'google_polyline.g.dart';

@JsonSerializable()
class GooglePolyline {
  String? points;

  GooglePolyline({this.points});

  factory GooglePolyline.fromJson(Map<String, dynamic> json) =>
      _$GooglePolylineFromJson(json);

  Map<String, dynamic> toJson() => _$GooglePolylineToJson(this);
}
