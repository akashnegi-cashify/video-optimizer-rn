import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'assembly_mark_done_response.g.dart';

@JsonSerializable()
class AssemblyMarkDoneResponse extends BaseResponse {
  @JsonKey(name: "s", defaultValue: false)
  late bool isSuccess;

  @JsonKey(name: "sm")
  String? successMsg;

  @JsonKey(name: "em")
  String? errorMsg;

  AssemblyMarkDoneResponse(super.cashifyAlert, super.trackUrl);

  static AssemblyMarkDoneResponse fromJson(Map<String, dynamic> json) => _$AssemblyMarkDoneResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AssemblyMarkDoneResponseToJson(this);
}
