import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guard_entry_scan_response.g.dart';

@JsonSerializable()
class GuardEntryScanResponse extends BaseResponse {

  @JsonKey(name: "s")
  int? status;

  GuardEntryScanResponse(this.status, super.cashifyAlert, super.trackUrl);

  static GuardEntryScanResponse fromJson(Map<String, dynamic> json) => _$GuardEntryScanResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GuardEntryScanResponseToJson(this);
}