// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_in_location_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreInLocationVerifyResponse _$StoreInLocationVerifyResponseFromJson(
        Map<String, dynamic> json) =>
    StoreInLocationVerifyResponse(
      success: (json['s'] as num?)?.toInt(),
      availableSpace: (json['ac'] as num?)?.toInt(),
      totalSpace: (json['tc'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$StoreInLocationVerifyResponseToJson(
        StoreInLocationVerifyResponse instance) =>
    <String, dynamic>{
      's': instance.success,
      'ac': instance.availableSpace,
      'tc': instance.totalSpace,
      'message': instance.message,
    };
