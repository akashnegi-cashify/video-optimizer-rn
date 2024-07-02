// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elss_option_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElssOptionResponse _$ElssOptionResponseFromJson(Map<String, dynamic> json) =>
    ElssOptionResponse(
      json['em'] as String?,
      json['s'] as bool?,
      json['r_id'] as String?,
      (json['dt'] as List<dynamic>?)
          ?.map((e) => OptionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ElssOptionResponseToJson(ElssOptionResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'em': instance.errorMessage,
      'dt': instance.listOfOptions,
    };

OptionResponse _$OptionResponseFromJson(Map<String, dynamic> json) =>
    OptionResponse(
      json['isra'] as bool?,
      json['isPna'] as bool?,
      json['isGc'] as bool?,
      (json['k'] as num?)?.toInt(),
      json['v'] as String?,
    );

Map<String, dynamic> _$OptionResponseToJson(OptionResponse instance) =>
    <String, dynamic>{
      'k': instance.key,
      'v': instance.optionName,
      'isra': instance.isRubbingApplicable,
      'isPna': instance.isPnaApplicable,
      'isGc': instance.isGlassChangeApplicable,
    };
