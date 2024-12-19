// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reason_submit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReasonSubmitRequest _$ReasonSubmitRequestFromJson(Map<String, dynamic> json) =>
    ReasonSubmitRequest(
      code: json['qrCode'] as String?,
      remark: json['remark'] as String?,
      qr: json['qr'] as String?,
      id: (json['id'] as num?)?.toInt(),
      actionRemark: json['actionRemark'] as String?,
    );

Map<String, dynamic> _$ReasonSubmitRequestToJson(
        ReasonSubmitRequest instance) =>
    <String, dynamic>{
      if (instance.code case final value?) 'qrCode': value,
      if (instance.remark case final value?) 'remark': value,
      if (instance.qr case final value?) 'qr': value,
      if (instance.id case final value?) 'id': value,
      if (instance.actionRemark case final value?) 'actionRemark': value,
    };
