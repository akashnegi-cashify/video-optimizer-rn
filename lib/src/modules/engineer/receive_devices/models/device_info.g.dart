// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo()
  ..deviceId = json['did'] as int
  ..productTitle = json['pt'] as String?
  ..deviceBarcode = json['dbr'] as String?
  ..status = json['st'] as String?;

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) => <String, dynamic>{
      'did': instance.deviceId,
      'pt': instance.productTitle,
      'dbr': instance.deviceBarcode,
      'st': instance.status,
    };
