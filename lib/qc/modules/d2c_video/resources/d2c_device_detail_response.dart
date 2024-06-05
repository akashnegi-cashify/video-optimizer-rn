import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'd2c_device_detail_response.g.dart';

@JsonSerializable()
class D2CDeviceDetailResponse extends BaseResponse {
  @JsonKey(name: 'dt')
  D2CDeviceDetail? response;

  D2CDeviceDetailResponse(this.response, super.cashifyAlert, super.trackUrl);

  static D2CDeviceDetailResponse fromJson(Map<String, dynamic> json) => _$D2CDeviceDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$D2CDeviceDetailResponseToJson(this);
}

@JsonSerializable()
class D2CDeviceDetail {
  @JsonKey(name: 'qr')
  String? deviceBarcode;

  @JsonKey(name: 'mn')
  String? modelName;

  static D2CDeviceDetail fromJson(Map<String, dynamic> json) => _$D2CDeviceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$D2CDeviceDetailToJson(this);
}
