import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scanned_awb_list_response.g.dart';

@JsonSerializable()
class ScannedAwbListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<ScannedAwbListData>? awbList;

  ScannedAwbListResponse(this.awbList, super.cashifyAlert, super.trackUrl);

  static ScannedAwbListResponse fromJson(Map<String, dynamic> json) => _$ScannedAwbListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ScannedAwbListResponseToJson(this);
}

@JsonSerializable()
class ScannedAwbListData {
  @JsonKey(name: "a")
  String? awb;

  ScannedAwbListData(this.awb);

  static ScannedAwbListData fromJson(Map<String, dynamic> json) => _$ScannedAwbListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ScannedAwbListDataToJson(this);
}
