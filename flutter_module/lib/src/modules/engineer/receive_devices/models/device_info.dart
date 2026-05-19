import 'package:json_annotation/json_annotation.dart';
part 'device_info.g.dart';

@JsonSerializable()
class DeviceInfo {
  @JsonKey(name: "deviceId")
  late int deviceId;
  @JsonKey(name: "productTitle")
  String? productTitle;
  @JsonKey(name: "deviceBarcode")
  String? deviceBarcode;
  @JsonKey(name: "status")
  String? status;

  static DeviceInfo fromJson(Map<String, dynamic> data) => _$DeviceInfoFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}
