// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_part_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelPartResponse _$CancelPartResponseFromJson(Map<String, dynamic> json) =>
    CancelPartResponse(
      isSuccess: json['s'] as bool?,
      refId: json['r_id'] as String?,
    );

Map<String, dynamic> _$CancelPartResponseToJson(CancelPartResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
    };
