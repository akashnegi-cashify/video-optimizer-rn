import 'package:json_annotation/json_annotation.dart';

part 'elss_success_response.g.dart';

@JsonSerializable()
class ElssSuccessResponse {
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "r_id")
  String? referenceId;
  @JsonKey(name: "pm")
  int? pm;

  ElssSuccessResponse({
    this.pm,
    this.referenceId,
    this.success,
  });

  static ElssSuccessResponse fromJson(Map<String, dynamic> data) => _$ElssSuccessResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ElssSuccessResponseToJson(this);
}
