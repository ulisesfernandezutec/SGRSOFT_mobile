import 'package:json_annotation/json_annotation.dart';

part 'google_duration.g.dart';

@JsonSerializable()
class GoogleDuration {
  String? text;
  int? value;

  GoogleDuration({this.text, this.value});

  factory GoogleDuration.fromJson(Map<String, dynamic> json) =>
      _$GoogleDurationFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleDurationToJson(this);
}
