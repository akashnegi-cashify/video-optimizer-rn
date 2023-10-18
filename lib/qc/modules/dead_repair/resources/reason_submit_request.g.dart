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
      id: json['id'] as int?,
      actionRemark: json['actionRemark'] as String?,
    );

Map<String, dynamic> _$ReasonSubmitRequestToJson(ReasonSubmitRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('qrCode', instance.code);
  writeNotNull('remark', instance.remark);
  writeNotNull('qr', instance.qr);
  writeNotNull('id', instance.id);
  writeNotNull('actionRemark', instance.actionRemark);
  return val;
}
