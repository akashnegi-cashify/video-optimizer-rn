// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_in_location_verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreInLocationVerifyResponse _$StoreInLocationVerifyResponseFromJson(Map<String, dynamic> json) =>
    StoreInLocationVerifyResponse(
      availableSpace: (json['availableCapacity'] as num?)?.toInt(),
      totalSpace: (json['totalCapacity'] as num?)?.toInt(),
      verifyBarcodeStatus: (json['verifyBarcodeStatus'] as num?)?.toInt(),
      message: json['message'] as String?,
      requestId: json['r_id'] as String?,
    );

Map<String, dynamic> _$StoreInLocationVerifyResponseToJson(StoreInLocationVerifyResponse instance) => <String, dynamic>{
      'availableCapacity': instance.availableSpace,
      'totalCapacity': instance.totalSpace,
      'verifyBarcodeStatus': instance.verifyBarcodeStatus,
      'message': instance.message,
      'r_id': instance.requestId,
    };

VerifyBarcode _$VerifyBarcodeFromJson(Map<String, dynamic> json) => VerifyBarcode(
      qrCode: json['qrCode'] as String?,
    );

Map<String, dynamic> _$VerifyBarcodeToJson(VerifyBarcode instance) => <String, dynamic>{
      'qrCode': instance.qrCode,
    };
