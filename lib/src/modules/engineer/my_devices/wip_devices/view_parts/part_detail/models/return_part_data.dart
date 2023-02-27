import 'package:json_annotation/json_annotation.dart';
part 'return_part_data.g.dart';

@JsonSerializable()
class ReturnPartData {
  @JsonKey(name: "pbr")
  String? partBarcode;
  @JsonKey(name: "pid")
  String? partId;
  @JsonKey(name: "rr")
  String? returnReason;
  @JsonKey(name: "remark")
  String? remark;
  @JsonKey(name: "prid")
  int? prid;

  ReturnPartData(this.partBarcode, this.partId, this.returnReason, this.remark, this.prid);

  static ReturnPartData fromJson(Map<String, dynamic> json) => _$ReturnPartDataFromJson(json);
  Map<String, dynamic> toJson() => _$ReturnPartDataToJson(this);
}
