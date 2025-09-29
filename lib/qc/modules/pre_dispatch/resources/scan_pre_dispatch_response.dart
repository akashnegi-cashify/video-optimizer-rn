import 'package:json_annotation/json_annotation.dart';

import 'index.dart';

part 'scan_pre_dispatch_response.g.dart';

@JsonSerializable()
class ScanPreDispatchResponse {
  @JsonKey(name: "cm")
  String? message;

  @JsonKey(name: "s")
  bool? status;

  @JsonKey(name: "success")
  bool? success;

  @JsonKey(name: "tc")
  int? totalCount;

  @JsonKey(name: "em")
  String? errorMessage;

  @JsonKey(includeFromJson: false,includeToJson: false)
  PreDispatchItem? preDispatchItem;

  ScanPreDispatchResponse({
    this.message,
    this.status,
    this.success,
    this.totalCount,
    this.preDispatchItem,
    this.errorMessage,
  });

  static ScanPreDispatchResponse fromJson(Map<String, dynamic> data) => _$ScanPreDispatchResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ScanPreDispatchResponseToJson(this);
}
