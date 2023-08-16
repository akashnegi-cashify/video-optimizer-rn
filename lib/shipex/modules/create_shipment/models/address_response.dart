
import 'package:json_annotation/json_annotation.dart';

part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {

  @JsonKey(name: 'sa1')
  String? savedAddress1;

  @JsonKey(name: 'sa2')
  String? sa2ForShprOnly;

  @JsonKey(name: 'c')
  String? city;

  @JsonKey(name: 's')
  String? state;

  @JsonKey(name: 'pc')
  String? pinCode;

  @JsonKey(name: 'lat')
  double? lat;

  @JsonKey(name: 'long')
  double? long;

  static AddressResponse fromJson(Map<String, dynamic> json) => _$AddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
}