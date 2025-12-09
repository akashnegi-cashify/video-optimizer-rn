import 'package:json_annotation/json_annotation.dart';

part 'reason_submit_request.g.dart';

@JsonSerializable()
class ReasonSubmitRequest {
  @JsonKey(name: "qrCode", includeIfNull: false)
  String? code;

  @JsonKey(name: "remark", includeIfNull: false)
  String? remark;

  @JsonKey(name: 'qr',includeIfNull: false)
  String? qr;

  @JsonKey(name: 'id',includeIfNull: false)
  int? id;

  @JsonKey(name: 'actionRemark',includeIfNull: false)
  String? actionRemark;

  /// For /repair/device/mark-repair: list of SKUs associated with the repair
  @JsonKey(name: 'skus', includeIfNull: false)
  List<String>? skus;

  ReasonSubmitRequest({
    this.code,
    this.remark,
    this.qr,
    this.id,
    this.actionRemark,
    this.skus,
  });

  static ReasonSubmitRequest fromJson(Map<String, dynamic> data) => _$ReasonSubmitRequestFromJson(data);

  Map<String, dynamic> toJson() => _$ReasonSubmitRequestToJson(this);
}
