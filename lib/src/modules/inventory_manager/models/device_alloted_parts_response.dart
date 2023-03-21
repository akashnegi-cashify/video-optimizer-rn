import 'package:json_annotation/json_annotation.dart';

part 'device_alloted_parts_response.g.dart';

@JsonSerializable()
class DeviceAllottedPartsResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  List<DeviceAllottedPartsData>? allottedPartsList;

  DeviceAllottedPartsResponse({
    this.isSuccess,
    this.refId,
    this.allottedPartsList,
  });

  static DeviceAllottedPartsResponse fromJson(Map<String, dynamic> data) => _$DeviceAllottedPartsResponseFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceAllottedPartsResponseToJson(this);
}

@JsonSerializable()
class DeviceAllottedPartsData {
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "pn")
  String? productName;
  @JsonKey(name: "st")
  String? status;
  @JsonKey(name: "stc")
  int? statusCode;
  @JsonKey(name: "prid")
  int? prid;
  @JsonKey(name: "prdt")
  int? requestedTime;
  @JsonKey(name: "isUrgent")
  bool? isUrgent;
  @JsonKey(name: "en")
  String? engineerName;

  DeviceAllottedPartsData({
    this.status,
    this.engineerName,
    this.isUrgent,
    this.prid,
    this.sku,
    this.statusCode,
    this.requestedTime,
    this.productName,
  });

  static DeviceAllottedPartsData fromJson(Map<String, dynamic> data) => _$DeviceAllottedPartsDataFromJson(data);

  Map<String, dynamic> toJson() => _$DeviceAllottedPartsDataToJson(this);
}
