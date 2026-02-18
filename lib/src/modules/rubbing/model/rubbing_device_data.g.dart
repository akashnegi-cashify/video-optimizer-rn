// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rubbing_device_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RubbingDeviceData _$RubbingDeviceDataFromJson(Map<String, dynamic> json) =>
    RubbingDeviceData()
      ..deviceId = (json['deviceId'] as num).toInt()
      ..productTitle = json['productTitle'] as String?
      ..deviceBarcode = json['deviceBarcode'] as String?
      ..trayBarcode = json['trayBarcode'] as String?
      ..assignedAt = (json['assignedAt'] as num?)?.toInt()
      ..isUrgent = json['isUrgent'] as bool?
      ..skewImageTaken = json['skewImageTaken'] as bool?;

Map<String, dynamic> _$RubbingDeviceDataToJson(RubbingDeviceData instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'productTitle': instance.productTitle,
      'deviceBarcode': instance.deviceBarcode,
      'trayBarcode': instance.trayBarcode,
      'assignedAt': instance.assignedAt,
      'isUrgent': instance.isUrgent,
      'skewImageTaken': instance.skewImageTaken,
    };
