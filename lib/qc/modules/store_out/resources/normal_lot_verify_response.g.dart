// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_lot_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalLotVerifyResponse _$NormalLotVerifyResponseFromJson(
        Map<String, dynamic> json) =>
    NormalLotVerifyResponse(
      message: json['message'] as String?,
      status: json['s'] as bool?,
    );

Map<String, dynamic> _$NormalLotVerifyResponseToJson(
        NormalLotVerifyResponse instance) =>
    <String, dynamic>{
      's': instance.status,
      'message': instance.message,
    };
