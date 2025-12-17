import 'package:json_annotation/json_annotation.dart';

part 'user_details_response.g.dart';

@JsonSerializable()
class UserDetailsResponse {
  @JsonKey(name: "firstname")
  String? firstName;
  @JsonKey(name: "mobile")
  String? mobileNumber;
  @JsonKey(name: "uid")
  String? uid;
  @JsonKey(name: "role")
  String? role;
  @JsonKey(name: 'username')
  String? userName;
  @JsonKey(name: 'mobileMd5')
  String? mobileMd5;
  @JsonKey(name: "roles")
  List<String>? listOfRoles;

  UserDetailsResponse({
    this.firstName,
    this.listOfRoles,
    this.mobileNumber,
    this.role,
    this.uid,
    this.userName,
    this.mobileMd5,
  });

  static UserDetailsResponse fromJson(Map<String, dynamic> data) => _$UserDetailsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$UserDetailsResponseToJson(this);
}
