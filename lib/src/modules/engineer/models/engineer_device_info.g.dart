// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engineer_device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EngineerDeviceInfo _$EngineerDeviceInfoFromJson(Map<String, dynamic> json) =>
    EngineerDeviceInfo()
      ..deviceId = (json['deviceId'] as num).toInt()
      ..returnReason = json['returnReason'] as String?
      ..productTitle = json['productTitle'] as String?
      ..deviceBarcode = json['deviceBarcode'] as String?
      ..status = json['status'] as String?
      ..repairType = json['repairType'] as String?
      ..grade = json['grade'] as String?
      ..imei = json['deviceImei'] as String?
      ..color = json['deviceColor'] as String?
      ..isUrgent = json['isUrgent'] as bool?
      ..skewImageTaken = json['skewImageTaken'] as bool?;

Map<String, dynamic> _$EngineerDeviceInfoToJson(EngineerDeviceInfo instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'returnReason': instance.returnReason,
      'productTitle': instance.productTitle,
      'deviceBarcode': instance.deviceBarcode,
      'status': instance.status,
      'repairType': instance.repairType,
      'grade': instance.grade,
      'deviceImei': instance.imei,
      'deviceColor': instance.color,
      'isUrgent': instance.isUrgent,
      'skewImageTaken': instance.skewImageTaken,
    };
