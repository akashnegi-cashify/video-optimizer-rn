import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'box_charger_tracking_response.g.dart';

@JsonSerializable()
class BoxChargerTrackingResponse extends BaseResponse {

  @JsonKey(name: "dt")
  BoxChargerTrackingData? boxChargerTrackingData;

  BoxChargerTrackingResponse(super.cashifyAlert, super.trackUrl);

  static BoxChargerTrackingResponse fromJson(Map<String, dynamic> json) => _$BoxChargerTrackingResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BoxChargerTrackingResponseToJson(this);
}

@JsonSerializable()
class BoxChargerTrackingData {

  @JsonKey(name: "hc")
  int? hasCharger;

  @JsonKey(name: "hb")
  int? hasBox;

  BoxChargerTrackingData(this.hasCharger, this.hasBox);

  static BoxChargerTrackingData fromJson(Map<String, dynamic> json) => _$BoxChargerTrackingDataFromJson(json);

  Map<String, dynamic> toJson() => _$BoxChargerTrackingDataToJson(this);
}