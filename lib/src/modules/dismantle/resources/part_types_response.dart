import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'part_types_response.g.dart';

@JsonSerializable()
class PartTypesResponse extends BaseResponse {
  @JsonKey(name: "isSuccess", defaultValue: false)
  late bool isSuccess;

  @JsonKey(name: "responseData")
  Map<String, String>? responseData;

  PartTypesResponse(super.cashifyAlert, super.trackUrl);

  static PartTypesResponse fromJson(Map<String, dynamic> json) => _$PartTypesResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PartTypesResponseToJson(this);
}
