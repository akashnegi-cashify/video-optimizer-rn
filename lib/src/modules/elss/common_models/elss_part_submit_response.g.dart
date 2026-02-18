// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elss_part_submit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElssPartSubmitResponse _$ElssPartSubmitResponseFromJson(
        Map<String, dynamic> json) =>
    ElssPartSubmitResponse(
      json['em'] as String?,
      json['sm'] as String?,
    );

Map<String, dynamic> _$ElssPartSubmitResponseToJson(
        ElssPartSubmitResponse instance) =>
    <String, dynamic>{
      'sm': instance.successMessage,
      'em': instance.errorMessage,
    };
