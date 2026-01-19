// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_pre_dispatch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletePreDispatchResponse _$CompletePreDispatchResponseFromJson(
        Map<String, dynamic> json) =>
    CompletePreDispatchResponse(
      message: json['cm'] as String?,
      status: (json['s'] as num?)?.toInt(),
      success: json['success'] as bool?,
      totalCount: (json['tc'] as num?)?.toInt(),
      errorMessage: json['em'] as String?,
    );

Map<String, dynamic> _$CompletePreDispatchResponseToJson(
        CompletePreDispatchResponse instance) =>
    <String, dynamic>{
      'cm': instance.message,
      's': instance.status,
      'success': instance.success,
      'tc': instance.totalCount,
      'em': instance.errorMessage,
    };
