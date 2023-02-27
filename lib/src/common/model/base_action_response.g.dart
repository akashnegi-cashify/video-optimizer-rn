// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_action_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseActionResponse _$BaseActionResponseFromJson(Map<String, dynamic> json) => BaseActionResponse(
      json['__ca'] == null ? null : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..refId = json['r_id'] as String?
      ..isSuccess = json['s'] as bool? ?? false
      ..errorMsg = json['em'] as String?;

Map<String, dynamic> _$BaseActionResponseToJson(BaseActionResponse instance) => <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.refId,
      's': instance.isSuccess,
      'em': instance.errorMsg,
    };
