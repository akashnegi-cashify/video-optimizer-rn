import 'package:json_annotation/json_annotation.dart';

part 'rubbing_device_data.g.dart';

@JsonSerializable()
class RubbingDeviceData {
  @JsonKey(name: "deviceId")
  late int deviceId;
  @JsonKey(name: "productTitle")
  String? productTitle;
  @JsonKey(name: "deviceBarcode")
  String? deviceBarcode;
  @JsonKey(name: "trayBarcode")
  String? trayBarcode;
  @JsonKey(name: "assignedAt")
  int? assignedAt;
  @JsonKey(name: "isUrgent")
  bool? isUrgent;
  @JsonKey(name: "skewImageTaken")
  bool? skewImageTaken;

  static RubbingDeviceData fromJson(Map<String, dynamic> data) => _$RubbingDeviceDataFromJson(data);

  Map<String, dynamic> toJson() => _$RubbingDeviceDataToJson(this);
}
