import 'package:json_annotation/json_annotation.dart';

import '../type.dart';

part 'accept_reject_dead_request.g.dart';

@JsonSerializable()
class AcceptRejectDeadRequest {
  @JsonKey(name: 'id',includeIfNull: false)
  int? markId;

  @JsonKey(name: 'remark',includeIfNull: false)
  String? remark;

  @JsonKey(name: 'actionRemark',includeIfNull: false)
  String? actionRemark;

  @JsonKey(name: 'skus',includeIfNull: false)
  List<String>? skus;

  @JsonKey(name: 'repairLevel',includeIfNull: false)
  String? repairLevel;

  @JsonKey(includeToJson: false,includeFromJson: false)
  DeadDeviceRequestType?  requestType;

  AcceptRejectDeadRequest({
    this.markId,
    this.remark,
    this.actionRemark,
    this.skus,
    this.repairLevel,
    this.requestType,
  });

  static AcceptRejectDeadRequest fromJson(Map<String, dynamic> data) => _$AcceptRejectDeadRequestFromJson(data);

  Map<String, dynamic> toJson() => _$AcceptRejectDeadRequestToJson(this);
}
