// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_reject_dead_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptRejectDeadRequest _$AcceptRejectDeadRequestFromJson(
        Map<String, dynamic> json) =>
    AcceptRejectDeadRequest(
      markId: json['id'] as int?,
      remark: json['remark'] as String?,
      actionRemark: json['actionRemark'] as String?,
      skus: (json['skus'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AcceptRejectDeadRequestToJson(
        AcceptRejectDeadRequest instance) =>
    <String, dynamic>{
      'id': instance.markId,
      'remark': instance.remark,
      'actionRemark': instance.actionRemark,
      'skus': instance.skus,
    };
