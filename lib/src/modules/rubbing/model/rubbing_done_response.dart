import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rubbing_done_response.g.dart';

@JsonSerializable()
class RubbingDoneResponse extends BaseResponse {
  @JsonKey(name: "s", defaultValue: false)
  late bool isSuccess;

  @JsonKey(name: "sm")
  String? successMsg;

  @JsonKey(name: "em")
  String? errorMsg;

  RubbingDoneResponse(super.cashifyAlert, super.trackUrl);

  static RubbingDoneResponse fromJson(Map<String, dynamic> data) => _$RubbingDoneResponseFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$RubbingDoneResponseToJson(this);
}
