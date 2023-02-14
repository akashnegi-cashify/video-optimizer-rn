import 'package:json_annotation/json_annotation.dart';

part 'parts_elss_action.g.dart';

@JsonSerializable()
class PartsElssActionResponse {
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "pm")
  int? pm;
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  ElssActionDataResponse? actionsData;

  PartsElssActionResponse({
    this.success,
    this.isSuccess,
    this.pm,
    this.actionsData,
    this.refId,
  });

  static PartsElssActionResponse fromJson(Map<String, dynamic> data) => _$PartsElssActionResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PartsElssActionResponseToJson(this);
}

@JsonSerializable()
class ElssActionDataResponse {
  @JsonKey(name: "Required")
  int? required;
  @JsonKey(name: "Not Required")
  int? notRequired;

  ElssActionDataResponse({
    this.required,
    this.notRequired,
  });

  static ElssActionDataResponse fromJson(Map<String, dynamic> data) => _$ElssActionDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ElssActionDataResponseToJson(this);
}
