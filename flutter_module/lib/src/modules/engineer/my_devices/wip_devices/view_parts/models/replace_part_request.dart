import 'package:json_annotation/json_annotation.dart';

part 'replace_part_request.g.dart';

@JsonSerializable()
class ReplacePartRequest {
  @JsonKey(name: "pbr")
  String? partBarcode;

  @JsonKey(name: "pdbr")
  String? previousDeviceBarCode; // device on which to remove

  @JsonKey(name: "ndbr")
  String? newDeviceBarCode;

  ReplacePartRequest(this.partBarcode, this.previousDeviceBarCode, this.newDeviceBarCode); // device on which to apply

  static ReplacePartRequest fromJson(Map<String, dynamic> json) => _$ReplacePartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReplacePartRequestToJson(this);
}
