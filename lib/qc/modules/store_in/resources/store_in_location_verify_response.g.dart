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
      barCodeList: (json['barCodeList'] as List<dynamic>?)
          ?.map((e) => VerifyBarcode.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'barCodeList': instance.barCodeList,
      'message': instance.message,
    };

VerifyBarcode _$VerifyBarcodeFromJson(Map<String, dynamic> json) =>
    VerifyBarcode(
      qrCode: json['qrCode'] as String?,
    );

Map<String, dynamic> _$VerifyBarcodeToJson(VerifyBarcode instance) =>
    <String, dynamic>{
      'qrCode': instance.qrCode,
    };
