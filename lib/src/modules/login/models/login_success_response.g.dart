// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginSuccessResponse _$LoginSuccessResponseFromJson(
        Map<String, dynamic> json) =>
    LoginSuccessResponse(
      status: json['s'] as bool?,
      referenceId: json['r_id'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoginSuccessResponseToJson(
        LoginSuccessResponse instance) =>
    <String, dynamic>{
      'r_id': instance.referenceId,
      'token': instance.token,
      's': instance.status,
    };
