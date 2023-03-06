// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parts_elss_action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartsElssActionResponse _$PartsElssActionResponseFromJson(
        Map<String, dynamic> json) =>
    PartsElssActionResponse(
      success: json['success'] as bool?,
      isSuccess: json['s'] as bool?,
      pm: json['pm'] as int?,
      actionsData: json['dt'] == null
          ? null
          : ElssActionDataResponse.fromJson(json['dt'] as Map<String, dynamic>),
      refId: json['r_id'] as String?,
    );

Map<String, dynamic> _$PartsElssActionResponseToJson(
        PartsElssActionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      's': instance.isSuccess,
      'pm': instance.pm,
      'r_id': instance.refId,
      'dt': instance.actionsData,
    };

ElssActionDataResponse _$ElssActionDataResponseFromJson(
        Map<String, dynamic> json) =>
    ElssActionDataResponse(
      required: json['Required'] as int?,
      notRequired: json['Not Required'] as int?,
    );

Map<String, dynamic> _$ElssActionDataResponseToJson(
        ElssActionDataResponse instance) =>
    <String, dynamic>{
      'Required': instance.required,
      'Not Required': instance.notRequired,
    };
