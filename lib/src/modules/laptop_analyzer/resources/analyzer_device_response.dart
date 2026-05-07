import 'package:json_annotation/json_annotation.dart';

part 'analyzer_device_response.g.dart';

@JsonSerializable()
class AnalyzerDevice {
  @JsonKey(name: "did")
  int? deviceId;

  @JsonKey(name: "dbr")
  String? deviceBarcode;

  @JsonKey(name: "mdl")
  String? model;

  @JsonKey(name: "sc")
  int? statusCode;

  @JsonKey(name: "sd")
  String? statusDescription;

  @JsonKey(name: "eng")
  String? engineer;

  @JsonKey(name: "img")
  String? image;

  AnalyzerDevice({
    this.deviceId,
    this.deviceBarcode,
    this.model,
    this.statusCode,
    this.statusDescription,
    this.engineer,
    this.image,
  });

  static AnalyzerDevice fromJson(Map<String, dynamic> data) => _$AnalyzerDeviceFromJson(data);

  Map<String, dynamic> toJson() => _$AnalyzerDeviceToJson(this);
}
