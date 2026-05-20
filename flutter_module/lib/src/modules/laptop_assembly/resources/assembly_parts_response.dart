import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assembly_parts_response.g.dart';

@JsonSerializable()
class AssemblyPartsResponse extends BaseResponse {
  @JsonKey(name: "s", defaultValue: false)
  late bool isSuccess;

  @JsonKey(name: "em")
  String? errorMsg;

  @JsonKey(name: "dt")
  List<AssemblyChildPart>? responseData;

  AssemblyPartsResponse(super.cashifyAlert, super.trackUrl);

  static AssemblyPartsResponse fromJson(Map<String, dynamic> json) => _$AssemblyPartsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AssemblyPartsResponseToJson(this);
}

@JsonSerializable()
class AssemblyChildPart {
  @JsonKey(name: "did")
  int? deviceId;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "pn")
  String? partName;

  @JsonKey(name: "sc")
  int? statusCode;

  @JsonKey(name: "sd")
  String? statusDescription;

  AssemblyChildPart({
    this.deviceId,
    this.deviceBarcode,
    this.partName,
    this.statusCode,
    this.statusDescription,
  });

  static AssemblyChildPart fromJson(Map<String, dynamic> json) => _$AssemblyChildPartFromJson(json);

  Map<String, dynamic> toJson() => _$AssemblyChildPartToJson(this);
}
