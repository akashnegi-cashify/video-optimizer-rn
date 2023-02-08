import 'package:json_annotation/json_annotation.dart';
part 'device_info.g.dart';

@JsonSerializable()
class DeviceInfo {
  @JsonKey(name: "did")
  late int deviceId;
  @JsonKey(name: "pt")
  String? productTitle;
  @JsonKey(name: "dbr")
  String? deviceBarcode;
  @JsonKey(name: "st")
  String? status;

  static DeviceInfo fromJson(Map<String, dynamic> data) => _$DeviceInfoFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}
