import 'package:json_annotation/json_annotation.dart';

part 'scan_pre_dispatch_lot_request.g.dart';

@JsonSerializable()
class ScanPreDispatchRequest {
  @JsonKey(name: "lotGroupName",includeIfNull: false)
  String? lotGroupName;

  @JsonKey(name: "qrCode",includeIfNull: false)
  String? qrCode;

  static ScanPreDispatchRequest fromJson(Map<String, dynamic> data) => _$ScanPreDispatchRequestFromJson(data);

  Map<String, dynamic> toJson() => _$ScanPreDispatchRequestToJson(this);

  ScanPreDispatchRequest({this.lotGroupName, this.qrCode});
}
