// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_report_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceReportData _$DeviceReportDataFromJson(Map<String, dynamic> json) =>
    DeviceReportData()
      ..totalAssignDevice = (json['tad'] as num?)?.toInt()
      ..markedOkDevice = (json['mod'] as num?)?.toInt()
      ..markedOkPassDevice = (json['mopd'] as num?)?.toInt()
      ..markedOkFailDevice = (json['mofd'] as num?)?.toInt()
      ..efficiency = (json['eff'] as num?)?.toDouble()
      ..avgRepairTime = (json['avgrt'] as num?)?.toInt();

Map<String, dynamic> _$DeviceReportDataToJson(DeviceReportData instance) =>
    <String, dynamic>{
      'tad': instance.totalAssignDevice,
      'mod': instance.markedOkDevice,
      'mopd': instance.markedOkPassDevice,
      'mofd': instance.markedOkFailDevice,
      'eff': instance.efficiency,
      'avgrt': instance.avgRepairTime,
    };
