import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'send_to_tl_response.g.dart';

@JsonSerializable()
class SendToTlResponse extends BaseActionResponse{

  SendToTlResponse(super.cashifyAlert, super.trackUrl);

  static SendToTlResponse fromJson(Map<String, dynamic> json) => _$SendToTlResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SendToTlResponseToJson(this);

}