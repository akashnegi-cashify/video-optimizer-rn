// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elss_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElssSuccessResponse _$ElssSuccessResponseFromJson(Map<String, dynamic> json) =>
    ElssSuccessResponse(
      isSuccess: json['s'] as bool?,
      pm: (json['pm'] as num?)?.toInt(),
      referenceId: json['r_id'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$ElssSuccessResponseToJson(
        ElssSuccessResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'r_id': instance.referenceId,
      's': instance.isSuccess,
      'pm': instance.pm,
    };
