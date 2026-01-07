// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo()
  ..deviceId = (json['deviceId'] as num).toInt()
  ..productTitle = json['productTitle'] as String?
  ..deviceBarcode = json['deviceBarcode'] as String?
  ..status = json['status'] as String?;

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'productTitle': instance.productTitle,
      'deviceBarcode': instance.deviceBarcode,
      'status': instance.status,
    };
