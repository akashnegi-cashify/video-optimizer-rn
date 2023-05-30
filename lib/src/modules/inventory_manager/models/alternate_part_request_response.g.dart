// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alternate_part_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlternatePartRequestResponse _$AlternatePartRequestResponseFromJson(
        Map<String, dynamic> json) =>
    AlternatePartRequestResponse(
      isSuccess: json['s'] as bool?,
      rid: json['r_id'] as String?,
    );

Map<String, dynamic> _$AlternatePartRequestResponseToJson(
        AlternatePartRequestResponse instance) =>
    <String, dynamic>{
      'r_id': instance.rid,
      's': instance.isSuccess,
    };

AlternatePartRequestData _$AlternatePartRequestDataFromJson(
        Map<String, dynamic> json) =>
    AlternatePartRequestData(
      prid: json['prid'] as int?,
      isUrgent: json['isUrgent'] as bool?,
    );

Map<String, dynamic> _$AlternatePartRequestDataToJson(
        AlternatePartRequestData instance) =>
    <String, dynamic>{
      'prid': instance.prid,
      'isUrgent': instance.isUrgent,
    };
