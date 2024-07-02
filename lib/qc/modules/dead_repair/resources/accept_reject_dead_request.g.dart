// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_reject_dead_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptRejectDeadRequest _$AcceptRejectDeadRequestFromJson(
        Map<String, dynamic> json) =>
    AcceptRejectDeadRequest(
      markId: (json['id'] as num?)?.toInt(),
      remark: json['remark'] as String?,
      actionRemark: json['actionRemark'] as String?,
      skus: (json['skus'] as List<dynamic>?)?.map((e) => e as String).toList(),
      repairLevel: json['repairLevel'] as String?,
    );

Map<String, dynamic> _$AcceptRejectDeadRequestToJson(
    AcceptRejectDeadRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.markId);
  writeNotNull('remark', instance.remark);
  writeNotNull('actionRemark', instance.actionRemark);
  writeNotNull('skus', instance.skus);
  writeNotNull('repairLevel', instance.repairLevel);
  return val;
}
