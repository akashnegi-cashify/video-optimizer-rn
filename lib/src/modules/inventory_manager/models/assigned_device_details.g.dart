// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_device_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignedDeviceDetails _$AssignedDeviceDetailsFromJson(
        Map<String, dynamic> json) =>
    AssignedDeviceDetails(
      isSuccess: json['s'] as bool?,
      refId: json['r_id'] as String?,
      detailsData: json['dt'] == null
          ? null
          : AssignDeviceDetailsData.fromJson(
              json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssignedDeviceDetailsToJson(
        AssignedDeviceDetails instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'dt': instance.detailsData,
    };

AssignDeviceDetailsData _$AssignDeviceDetailsDataFromJson(
        Map<String, dynamic> json) =>
    AssignDeviceDetailsData(
      did: json['did'] as int?,
      lc: json['lc'] as String?,
      engineerName: json['en'] as String?,
      deviceBarcode: json['dbr'] as String?,
      status: json['st'] as String?,
      grade: json['gr'] as String?,
      repairType: json['rt'] as String?,
      productName: json['pt'] as String?,
      deadRemark: json['dr'] as String?,
    );

Map<String, dynamic> _$AssignDeviceDetailsDataToJson(
        AssignDeviceDetailsData instance) =>
    <String, dynamic>{
      'did': instance.did,
      'pt': instance.productName,
      'dbr': instance.deviceBarcode,
      'st': instance.status,
      'en': instance.engineerName,
      'rt': instance.repairType,
      'gr': instance.grade,
      'lc': instance.lc,
      'dr': instance.deadRemark,
    };
