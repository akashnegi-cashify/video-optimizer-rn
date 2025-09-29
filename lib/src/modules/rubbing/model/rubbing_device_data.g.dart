// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rubbing_device_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RubbingDeviceData _$RubbingDeviceDataFromJson(Map<String, dynamic> json) =>
    RubbingDeviceData()
      ..deviceId = (json['did'] as num).toInt()
      ..productTitle = json['pt'] as String?
      ..deviceBarcode = json['dbr'] as String?
      ..trayBarcode = json['tbr'] as String?;

Map<String, dynamic> _$RubbingDeviceDataToJson(RubbingDeviceData instance) =>
    <String, dynamic>{
      'did': instance.deviceId,
      'pt': instance.productTitle,
      'dbr': instance.deviceBarcode,
      'tbr': instance.trayBarcode,
    };
