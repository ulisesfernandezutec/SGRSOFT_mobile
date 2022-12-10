import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sgrsoft/domain/models/rol.dart';

part 'api_glogin.g.dart';

@JsonSerializable(explicitToJson: true)
// ignore: must_be_immutable
class ApiGLogin extends Equatable {
  String? scope;
  String? azp;
  String? aud;
  String? sub;
  String? email;
  String? emailVerified;
  String? exp;
  String? expiresIn;
  String? accessType;
  String sgrToken;
  Rol rol;

  ApiGLogin(
      {this.scope,
      this.azp,
      this.aud,
      this.sub,
      this.email,
      this.emailVerified,
      this.exp,
      this.expiresIn,
      this.accessType,
      required this.sgrToken,
      required this.rol});

  factory ApiGLogin.fromJson(Map<String, dynamic> json) =>
      _$ApiGLoginFromJson(json);

  Map<String, dynamic> toJson() => _$ApiGLoginToJson(this);

  @override
  List<Object?> get props => [rol, sgrToken];
}
