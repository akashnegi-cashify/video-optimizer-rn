import 'package:json_annotation/json_annotation.dart';

part 'rubbing_device_data.g.dart';

@JsonSerializable()
class RubbingDeviceData {
  @JsonKey(name: "did")
  late int deviceId;
  @JsonKey(name: "pt")
  String? productTitle;
  @JsonKey(name: "dbr")
  String? deviceBarcode;
  @JsonKey(name: "tbr")
  String? trayBarcode;

  static RubbingDeviceData fromJson(Map<String, dynamic> data) => _$RubbingDeviceDataFromJson(data);

  Map<String, dynamic> toJson() => _$RubbingDeviceDataToJson(this);
}
