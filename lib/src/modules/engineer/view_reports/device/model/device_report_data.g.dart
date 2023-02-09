// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_report_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceReportData _$DeviceReportDataFromJson(Map<String, dynamic> json) =>
    DeviceReportData()
      ..totalAssignDevice = json['tad'] as int?
      ..markedOkDevice = json['mod'] as int?
      ..markedOkPassDevice = json['mopd'] as int?
      ..markedOkFailDevice = json['mofd'] as int?
      ..efficiency = (json['eff'] as num?)?.toDouble()
      ..avgRepairTime = json['avgrt'] as int?;

Map<String, dynamic> _$DeviceReportDataToJson(DeviceReportData instance) =>
    <String, dynamic>{
      'tad': instance.totalAssignDevice,
      'mod': instance.markedOkDevice,
      'mopd': instance.markedOkPassDevice,
      'mofd': instance.markedOkFailDevice,
      'eff': instance.efficiency,
      'avgrt': instance.avgRepairTime,
    };
