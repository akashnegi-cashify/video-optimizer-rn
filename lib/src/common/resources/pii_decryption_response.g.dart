// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pii_decryption_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PiiDecryptionResponse _$PiiDecryptionResponseFromJson(
        Map<String, dynamic> json) =>
    PiiDecryptionResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..data = json['data'] as String?
      ..piiEnum = json['piiEnum'] as String?
      ..displayData = json['displayData'] as String?;

Map<String, dynamic> _$PiiDecryptionResponseToJson(
        PiiDecryptionResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'data': instance.data,
      'piiEnum': instance.piiEnum,
      'displayData': instance.displayData,
    };
