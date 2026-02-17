// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bin_out_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BinOutVerifyResponse _$BinOutVerifyResponseFromJson(
        Map<String, dynamic> json) =>
    BinOutVerifyResponse(
      availableSpace: (json['ac'] as num?)?.toInt(),
      totalSpace: (json['tc'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BinOutVerifyResponseToJson(
        BinOutVerifyResponse instance) =>
    <String, dynamic>{
      'ac': instance.availableSpace,
      'tc': instance.totalSpace,
      'message': instance.message,
    };
