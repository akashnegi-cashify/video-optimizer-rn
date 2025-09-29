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
        AcceptRejectDeadRequest instance) =>
    <String, dynamic>{
      if (instance.markId case final value?) 'id': value,
      if (instance.remark case final value?) 'remark': value,
      if (instance.actionRemark case final value?) 'actionRemark': value,
      if (instance.skus case final value?) 'skus': value,
      if (instance.repairLevel case final value?) 'repairLevel': value,
    };
