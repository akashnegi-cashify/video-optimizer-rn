import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device_accessories_list_response.g.dart';

@JsonSerializable()
class DeviceAccessoriesListResponse extends BaseResponse {
  @JsonKey(name: "dt")
  List<DeviceAccessoriesListData>? accessoriesList;

  DeviceAccessoriesListResponse(super.cashifyAlert, super.trackUrl, this.accessoriesList);

  static DeviceAccessoriesListResponse fromJson(Map<String, dynamic> json) =>
      _$DeviceAccessoriesListResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DeviceAccessoriesListResponseToJson(this);
}

@JsonSerializable()
class DeviceAccessoriesListData {
  @JsonKey(name: "l")
  String? label;

  @JsonKey(name: "v")
  String? value;

  DeviceAccessoriesListData({this.label, this.value});

  static DeviceAccessoriesListData fromJson(Map<String, dynamic> json) => _$DeviceAccessoriesListDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceAccessoriesListDataToJson(this);
}
