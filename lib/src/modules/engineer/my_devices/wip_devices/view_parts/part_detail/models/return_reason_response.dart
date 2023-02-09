

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'return_reason_response.g.dart';

@JsonSerializable()
class ReturnReasonResponse extends BaseActionResponse{

  @JsonKey(name:"dt")
  List<String>? reasons;

  ReturnReasonResponse(super.cashifyAlert, super.trackUrl);

  static ReturnReasonResponse fromJson(Map<String, dynamic> json) => _$ReturnReasonResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ReturnReasonResponseToJson(this);

}