import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dispatch_awb_scan_response.g.dart';

@JsonSerializable()
class DispatchAwbScanResponse extends BaseResponse {
  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "awb")
  String? awbNumber;

  @JsonKey(name: "isVal")
  bool? isValid;

  DispatchAwbScanResponse(this.name, this.awbNumber, this.isValid, super.cashifyAlert, super.trackUrl);

  static DispatchAwbScanResponse fromJson(Map<String, dynamic> json) => _$DispatchAwbScanResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DispatchAwbScanResponseToJson(this);
}
