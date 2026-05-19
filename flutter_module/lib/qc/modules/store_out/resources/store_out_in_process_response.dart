import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_out_in_process_response.g.dart';

@JsonSerializable()
class StoreOutInProcessResponse extends BaseResponse {

  @JsonKey(name: "storeOutStatus")
  bool? storeOutStatus;

  @JsonKey(name: "lotId")
  int? lotId;

  StoreOutInProcessResponse(this.storeOutStatus, this.lotId, super.cashifyAlert, super.trackUrl);

  static StoreOutInProcessResponse fromJson(Map<String, dynamic> json) =>
      _$StoreOutInProcessResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StoreOutInProcessResponseToJson(this);
}
