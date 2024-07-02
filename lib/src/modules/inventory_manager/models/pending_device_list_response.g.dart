// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_device_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingDeviceListResponse _$PendingDeviceListResponseFromJson(
        Map<String, dynamic> json) =>
    PendingDeviceListResponse(
      isSuccess: json['s'] as bool?,
      refId: json['r_id'] as String?,
      data: json['dt'] == null
          ? null
          : PendingDeviceData.fromJson(json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PendingDeviceListResponseToJson(
        PendingDeviceListResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
      's': instance.isSuccess,
      'dt': instance.data,
    };

PendingDeviceData _$PendingDeviceDataFromJson(Map<String, dynamic> json) =>
    PendingDeviceData(
      totalPage: (json['tp'] as num?)?.toInt(),
      totalRecords: (json['tr'] as num?)?.toInt(),
      dataList: (json['dl'] as List<dynamic>?)
          ?.map((e) =>
              PendingDeviceDetailData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PendingDeviceDataToJson(PendingDeviceData instance) =>
    <String, dynamic>{
      'tp': instance.totalPage,
      'tr': instance.totalRecords,
      'dl': instance.dataList,
    };

PendingDeviceDetailData _$PendingDeviceDetailDataFromJson(
        Map<String, dynamic> json) =>
    PendingDeviceDetailData(
      isUrgent: json['isUrgent'] as bool?,
      repairType: json['rt'] as String?,
      partCount: (json['pc'] as num?)?.toInt(),
      grade: json['gr'] as String?,
      deviceBarcode: json['dbr'] as String?,
      assignedAt: (json['asAt'] as num?)?.toInt(),
      did: (json['did'] as num?)?.toInt(),
      engineerName: json['en'] as String?,
      lc: json['lc'] as String?,
      pt: json['pt'] as String?,
      tbr: json['tbr'] as String?,
      totalPartCount: (json['tpc'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PendingDeviceDetailDataToJson(
        PendingDeviceDetailData instance) =>
    <String, dynamic>{
      'did': instance.did,
      'pt': instance.pt,
      'dbr': instance.deviceBarcode,
      'tbr': instance.tbr,
      'pc': instance.partCount,
      'tpc': instance.totalPartCount,
      'en': instance.engineerName,
      'lc': instance.lc,
      'asAt': instance.assignedAt,
      'isUrgent': instance.isUrgent,
      'rt': instance.repairType,
      'gr': instance.grade,
    };
