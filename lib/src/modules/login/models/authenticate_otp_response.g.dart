// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticate_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticateOTPResponse _$AuthenticateOTPResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticateOTPResponse(
      json['token_type'] as String?,
      json['access_token'] as String?,
      (json['expires_in'] as num?)?.toInt() ?? 0,
      (json['isp'] as num?)?.toInt() ?? 0,
      json['refresh_token'] as String?,
    );

Map<String, dynamic> _$AuthenticateOTPResponseToJson(
        AuthenticateOTPResponse instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'isp': instance.isPublic,
      'expires_in': instance.expiresIn,
    };
