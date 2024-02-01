// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_analytic_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveAnalyticsRequest _$SaveAnalyticsRequestFromJson(
        Map<String, dynamic> json) =>
    SaveAnalyticsRequest(
      json['ekey'] as String?,
      json['sokey'] as String?,
      parameters: json['pldata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SaveAnalyticsRequestToJson(
        SaveAnalyticsRequest instance) =>
    <String, dynamic>{
      'ekey': instance.eventKey,
      'sokey': instance.subOrdinateEventKey,
      'pldata': instance.parameters,
    };
