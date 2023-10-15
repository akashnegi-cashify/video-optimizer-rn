// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bin_out_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BinOutVerifyResponse _$BinOutVerifyResponseFromJson(
        Map<String, dynamic> json) =>
    BinOutVerifyResponse(
      success: json['s'] as int?,
      availableSpace: json['ac'] as int?,
      totalSpace: json['tc'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BinOutVerifyResponseToJson(
        BinOutVerifyResponse instance) =>
    <String, dynamic>{
      's': instance.success,
      'ac': instance.availableSpace,
      'tc': instance.totalSpace,
      'message': instance.message,
    };
