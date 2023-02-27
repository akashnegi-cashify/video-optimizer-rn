// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_native_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NativeData _$NativeDataFromJson(Map<String, dynamic> json) => NativeData(
      token: json['token'] as String?,
      authResponse: json['authData'] == null ? null : OAuthResponse.fromJson(json['authData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NativeDataToJson(NativeData instance) => <String, dynamic>{
      'token': instance.token,
      'authData': instance.authResponse,
    };
