// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'engineer_device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EngineerDeviceInfo _$EngineerDeviceInfoFromJson(Map<String, dynamic> json) =>
    EngineerDeviceInfo()
      ..deviceId = json['did'] as int
      ..returnReason = json['rr'] as String?
      ..productTitle = json['pt'] as String?
      ..deviceBarcode = json['dbr'] as String?
      ..status = json['st'] as String?
      ..repairType = json['rt'] as String?
      ..grade = json['gr'] as String?
      ..imei = json['dimei'] as String?
      ..color = json['dc'] as String?
      ..repairReasonList =
          (json['rrs'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$EngineerDeviceInfoToJson(EngineerDeviceInfo instance) =>
    <String, dynamic>{
      'did': instance.deviceId,
      'rr': instance.returnReason,
      'pt': instance.productTitle,
      'dbr': instance.deviceBarcode,
      'st': instance.status,
      'rt': instance.repairType,
      'gr': instance.grade,
      'dimei': instance.imei,
      'dc': instance.color,
      'rrs': instance.repairReasonList,
    };
