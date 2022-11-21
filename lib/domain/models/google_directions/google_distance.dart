import 'package:json_annotation/json_annotation.dart';

part 'google_distance.g.dart';

@JsonSerializable()
class GoogleDistance {
  String? text;
  int? value;

  GoogleDistance({this.text, this.value});

  factory GoogleDistance.fromJson(Map<String, dynamic> json) =>
      _$GoogleDistanceFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleDistanceToJson(this);
}
