// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rubbing_done_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RubbingDoneResponse _$RubbingDoneResponseFromJson(Map<String, dynamic> json) =>
    RubbingDoneResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..isSuccess = json['s'] as bool? ?? false
      ..successMsg = json['sm'] as String?
      ..errorMsg = json['em'] as String?;

Map<String, dynamic> _$RubbingDoneResponseToJson(
        RubbingDoneResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      's': instance.isSuccess,
      'sm': instance.successMsg,
      'em': instance.errorMsg,
    };
