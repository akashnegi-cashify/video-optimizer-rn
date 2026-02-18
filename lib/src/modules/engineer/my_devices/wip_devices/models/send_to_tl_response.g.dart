// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_to_tl_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendToTlResponse _$SendToTlResponseFromJson(Map<String, dynamic> json) =>
    SendToTlResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..refId = json['r_id'] as String?
      ..isSuccess = json['s'] as bool? ?? false
      ..errorMsg = json['em'] as String?
      ..successMessage = json['sm'] as String?;

Map<String, dynamic> _$SendToTlResponseToJson(SendToTlResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.refId,
      's': instance.isSuccess,
      'em': instance.errorMsg,
      'sm': instance.successMessage,
    };
