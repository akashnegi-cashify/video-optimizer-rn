// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutResponse _$LogoutResponseFromJson(Map<String, dynamic> json) =>
    LogoutResponse(
      (json['s'] as num?)?.toInt(),
      json['r_id'] as String?,
      json['msg'] as String?,
    );

Map<String, dynamic> _$LogoutResponseToJson(LogoutResponse instance) =>
    <String, dynamic>{
      'r_id': instance.referenceId,
      's': instance.status,
      'msg': instance.successMessage,
    };
