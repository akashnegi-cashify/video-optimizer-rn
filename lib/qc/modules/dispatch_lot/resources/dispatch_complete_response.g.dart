// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispatch_complete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DispatchCompleteResponse _$DispatchCompleteResponseFromJson(
        Map<String, dynamic> json) =>
    DispatchCompleteResponse(
      data: json['dt'] as String?,
      errorMsg: json['em'] as String?,
      isSuccess: json['s'] as bool?,
    );

Map<String, dynamic> _$DispatchCompleteResponseToJson(
        DispatchCompleteResponse instance) =>
    <String, dynamic>{
      'dt': instance.data,
      'em': instance.errorMsg,
      's': instance.isSuccess,
    };
