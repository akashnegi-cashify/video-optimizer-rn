// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_in_device_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreInDeviceRequest _$StoreInDeviceRequestFromJson(
        Map<String, dynamic> json) =>
    StoreInDeviceRequest(
      stockBarcode: json['stockBarcode'] as String?,
      locBarcode: json['locBarcode'] as String?,
    );

Map<String, dynamic> _$StoreInDeviceRequestToJson(
        StoreInDeviceRequest instance) =>
    <String, dynamic>{
      'stockBarcode': instance.stockBarcode,
      'locBarcode': instance.locBarcode,
    };
