// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_base_action_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewBaseActionResponse _$NewBaseActionResponseFromJson(Map<String, dynamic> json) =>
    NewBaseActionResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..refId = json['r_id'] as String?
      ..errorMsg = json['em'] as String?
      ..successMessage = json['sm'] as String?;

Map<String, dynamic> _$NewBaseActionResponseToJson(NewBaseActionResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'r_id': instance.refId,
      'em': instance.errorMsg,
      'sm': instance.successMessage,
    };
