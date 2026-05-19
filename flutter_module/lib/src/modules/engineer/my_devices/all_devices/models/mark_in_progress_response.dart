import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models/engineer_action_response.dart';

part 'mark_in_progress_response.g.dart';

@JsonSerializable()
class MarkInProgressResponse extends EngineerActionResponse {
  MarkInProgressResponse(super.cashifyAlert, super.trackUrl);

  static MarkInProgressResponse fromJson(Map<String, dynamic> json) => _$MarkInProgressResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MarkInProgressResponseToJson(this);
}
