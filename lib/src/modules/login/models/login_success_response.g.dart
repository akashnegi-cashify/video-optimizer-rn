// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_success_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginSuccessResponse _$LoginSuccessResponseFromJson(Map<String, dynamic> json) => LoginSuccessResponse(
      referenceId: json['r_id'] as String?,
      data: json['dt'] == null ? null : LoginSuccessData.fromJson(json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginSuccessResponseToJson(LoginSuccessResponse instance) => <String, dynamic>{
      'r_id': instance.referenceId,
      'dt': instance.data,
    };

LoginSuccessData _$LoginSuccessDataFromJson(Map<String, dynamic> json) => LoginSuccessData(
      json['token'] as String?,
      json['s'] as bool?,
    );

Map<String, dynamic> _$LoginSuccessDataToJson(LoginSuccessData instance) => <String, dynamic>{
      'token': instance.token,
      's': instance.status,
    };
