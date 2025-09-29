// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glass_change_fail_reason_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlassChangeFailReasonResponse _$GlassChangeFailReasonResponseFromJson(
        Map<String, dynamic> json) =>
    GlassChangeFailReasonResponse(
      (json['dt'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$GlassChangeFailReasonResponseToJson(
        GlassChangeFailReasonResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'dt': instance.reasonMap,
    };
