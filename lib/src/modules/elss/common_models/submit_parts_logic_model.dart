import 'package:json_annotation/json_annotation.dart';

part 'submit_parts_logic_model.g.dart';

@JsonSerializable()
class SubmitPartsLogicResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "pm")
  int? pm;
  @JsonKey(name: "dt")
  SubmitPartsLogicData? data;

  SubmitPartsLogicResponse({
    this.success,
    this.pm,
    this.isSuccess,
    this.data,
    this.refId,
  });

  static SubmitPartsLogicResponse fromJson(Map<String, dynamic> data) => _$SubmitPartsLogicResponseFromJson(data);

  Map<String, dynamic> toJson() => _$SubmitPartsLogicResponseToJson(this);
}

@JsonSerializable()
class SubmitPartsLogicData {
  @JsonKey(name: "opal")
  bool? optionsAllowed;

  SubmitPartsLogicData({
    this.optionsAllowed,
  });

  static SubmitPartsLogicData fromJson(Map<String, dynamic> data) => _$SubmitPartsLogicDataFromJson(data);

  Map<String, dynamic> toJson() => _$SubmitPartsLogicDataToJson(this);
}
