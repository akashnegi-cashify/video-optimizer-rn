import 'package:json_annotation/json_annotation.dart';

part 'vendor_response.g.dart';


@JsonSerializable()
class VendorResponse {

  @JsonKey(name: 'cc')
  String? customerCode;

  @JsonKey(name: 'bn')
  String? businessName;

  @JsonKey(name: 'em')
  String? email;

  @JsonKey(name: 'n')
  String? name;


  static VendorResponse fromJson(Map<String, dynamic> json) => _$VendorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VendorResponseToJson(this);
}