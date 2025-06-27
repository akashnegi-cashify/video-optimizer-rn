import 'dart:core';

import 'package:flutter_trc/src/common/model/device_part.dart';
import 'package:json_annotation/json_annotation.dart';

part 'engineer_part_info.g.dart';

@JsonSerializable()
class EngineerPartInfo extends DevicePart {
  @JsonKey(name: "st")
  String? status;

  @JsonKey(name: "stc")
  int? statusCode;

  @JsonKey(name: "rvc")
  int? retrievedImageCount;

  @JsonKey(name: "isrpa")
  bool? isRetrievedPartAssign;

  static EngineerPartInfo fromJson(Map<String, dynamic> data) => _$EngineerPartInfoFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$EngineerPartInfoToJson(this);
}

enum Status {
  engineerStatusAllotted("Alloted"),
  engineerStatusDeliveryPicked("Rider Delivery Picked");

  final String value;

  const Status(this.value);
}

enum StatusCode {
  availableStatusCode(12),
  notAvailableStatusCode(13),
  requestedStatusCode(11),
  allottedStatusCode(22),
  riderDeliveryPickedStatusCode(25),
  receiveStatusCode(33),
  consumedStatusCode(99),
  initiated(0);

  final int value;

  const StatusCode(this.value);
}
