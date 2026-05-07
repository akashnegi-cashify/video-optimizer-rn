// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_to_tl_reasons_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkToTlReasonsResponse _$MarkToTlReasonsResponseFromJson(Map<String, dynamic> json) =>
    MarkToTlReasonsResponse(
      json['__ca'] == null ? null : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..isSuccess = json['isSuccess'] as bool? ?? false
      ..responseData = (json['responseData'] as List<dynamic>?)
          ?.map((e) => MarkToTlReason.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MarkToTlReasonsResponseToJson(MarkToTlReasonsResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'isSuccess': instance.isSuccess,
      'responseData': instance.responseData,
    };

MarkToTlReason _$MarkToTlReasonFromJson(Map<String, dynamic> json) =>
    MarkToTlReason(
      id: (json['id'] as num?)?.toInt(),
      reason: json['rsn'] as String?,
    );

Map<String, dynamic> _$MarkToTlReasonToJson(MarkToTlReason instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rsn': instance.reason,
    };
