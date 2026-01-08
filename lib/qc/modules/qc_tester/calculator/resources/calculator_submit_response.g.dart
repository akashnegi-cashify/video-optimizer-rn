// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calculator_submit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalculatorSubmitResponse _$CalculatorSubmitResponseFromJson(
        Map<String, dynamic> json) =>
    CalculatorSubmitResponse(
      json['grade'] as String?,
      json['cautionMessage'] as String?,
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$CalculatorSubmitResponseToJson(
        CalculatorSubmitResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'grade': instance.grade,
      'cautionMessage': instance.cautionMessage,
    };
