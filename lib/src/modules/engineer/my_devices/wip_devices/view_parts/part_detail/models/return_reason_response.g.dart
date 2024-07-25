// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_reason_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnReasonResponse _$ReturnReasonResponseFromJson(
        Map<String, dynamic> json) =>
    ReturnReasonResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..refId = json['r_id'] as String?
      ..isSuccess = json['s'] as bool? ?? false
      ..errorMsg = json['em'] as String?
      ..successMessage = json['sm'] as String?
      ..reasons =
          (json['dt'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$ReturnReasonResponseToJson(
        ReturnReasonResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.refId,
      's': instance.isSuccess,
      'em': instance.errorMsg,
      'sm': instance.successMessage,
      'dt': instance.reasons,
    };
