// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_parts_logic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitPartsLogicResponse _$SubmitPartsLogicResponseFromJson(
        Map<String, dynamic> json) =>
    SubmitPartsLogicResponse(
      success: json['success'] as bool?,
      pm: json['pm'] as int?,
      isSuccess: json['s'] as bool?,
      data: json['dt'] == null
          ? null
          : SubmitPartsLogicData.fromJson(json['dt'] as Map<String, dynamic>),
      refId: json['r_id'] as String?,
    );

Map<String, dynamic> _$SubmitPartsLogicResponseToJson(
        SubmitPartsLogicResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'success': instance.success,
      'pm': instance.pm,
      'dt': instance.data,
    };

SubmitPartsLogicData _$SubmitPartsLogicDataFromJson(
        Map<String, dynamic> json) =>
    SubmitPartsLogicData(
      optionsAllowed: json['opal'] as bool?,
    );

Map<String, dynamic> _$SubmitPartsLogicDataToJson(
        SubmitPartsLogicData instance) =>
    <String, dynamic>{
      'opal': instance.optionsAllowed,
    };
