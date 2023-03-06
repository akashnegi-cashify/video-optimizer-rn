import 'package:json_annotation/json_annotation.dart';

part 'user_details_response.g.dart';

@JsonSerializable()
class UserDetailsResponse {
  @JsonKey(name: "fname")
  String? firstName;
  @JsonKey(name: "mn")
  String? mobileNumber;
  @JsonKey(name: "uid")
  String? uid;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: 'uname')
  String? userName;
  @JsonKey(name: "kid")
  String? kid;
  @JsonKey(name: "roles")
  List<String>? listOfRoles;
  @JsonKey(name: "clid")
  String? clid;
  @JsonKey(name: "clv")
  String? clv;
  @JsonKey(name: "exp")
  int? exp;
  @JsonKey(name: "gt")
  String? gt;
  @JsonKey(name: "vt")
  int? vt;

  UserDetailsResponse({
    this.clid,
    this.clv,
    this.exp,
    this.firstName,
    this.gt,
    this.kid,
    this.listOfRoles,
    this.mobileNumber,
    this.role,
    this.uid,
    this.userName,
    this.vt,
  });

  static UserDetailsResponse fromJson(Map<String, dynamic> data) => _$UserDetailsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$UserDetailsResponseToJson(this);
}
