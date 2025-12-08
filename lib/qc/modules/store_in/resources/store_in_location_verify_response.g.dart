// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_in_location_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreInLocationVerifyResponse _$StoreInLocationVerifyResponseFromJson(
        Map<String, dynamic> json) =>
    StoreInLocationVerifyResponse(
      success: (json['s'] as num?)?.toInt(),
      availableSpace: (json['availableCapacity'] as num?)?.toInt(),
      totalSpace: (json['totalCapacity'] as num?)?.toInt(),
      verifyBarcodeStatus: (json['verifyBarcodeStatus'] as num?)?.toInt(),
      performanceMonitoring: (json['pm'] as num?)?.toDouble(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$StoreInLocationVerifyResponseToJson(
        StoreInLocationVerifyResponse instance) =>
    <String, dynamic>{
      's': instance.success,
      'availableCapacity': instance.availableSpace,
      'totalCapacity': instance.totalSpace,
      'verifyBarcodeStatus': instance.verifyBarcodeStatus,
      'pm': instance.performanceMonitoring,
      'message': instance.message,
    };
