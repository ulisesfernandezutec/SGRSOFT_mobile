// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'google_directions.g.dart';

// @JsonSerializable()
// class GoogleDirections extends Equatable {
//   @HiveField(0)
//   @JsonKey(name: '_id')
//   int id;

//   List<GeocodedWaypoints>? geocodedWaypoints;
//   List<Routes>? routes;
//   String? status;

//   GoogleDirections({this.geocodedWaypoints, this.routes, this.status});


//   factory GoogleDirections.fromJson(Map<String, dynamic> json) =>
//       _$GoogleDirectionsFromJson(json);

//   Map<String, dynamic> toJson() => _$GoogleDirectionsToJson(this);

//   @override
//   List<Object?> get props => [id];
// }
