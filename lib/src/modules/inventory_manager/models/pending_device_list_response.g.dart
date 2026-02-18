// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_device_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingDeviceListResponse _$PendingDeviceListResponseFromJson(
        Map<String, dynamic> json) =>
    PendingDeviceListResponse(
      refId: json['r_id'] as String?,
      data: json['dt'] == null
          ? null
          : PendingDeviceData.fromJson(json['dt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PendingDeviceListResponseToJson(
        PendingDeviceListResponse instance) =>
    <String, dynamic>{
      'r_id': instance.refId,
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
      repairType: json['repairType'] as String?,
      partAvailableCount: (json['partAvailableCount'] as num?)?.toInt(),
      grade: json['grade'] as String?,
      deviceBarcode: json['deviceBarcode'] as String?,
      assignedAt: (json['assignedAt'] as num?)?.toInt(),
      deviceId: (json['deviceId'] as num?)?.toInt(),
      engineerName: json['engineerName'] as String?,
      location: json['location'] as String?,
      productTitle: json['productTitle'] as String?,
      trayBarcode: json['trayBarcode'] as String?,
      totalPartCount: (json['totalPartCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PendingDeviceDetailDataToJson(
        PendingDeviceDetailData instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'productTitle': instance.productTitle,
      'deviceBarcode': instance.deviceBarcode,
      'trayBarcode': instance.trayBarcode,
      'partAvailableCount': instance.partAvailableCount,
      'totalPartCount': instance.totalPartCount,
      'engineerName': instance.engineerName,
      'location': instance.location,
      'assignedAt': instance.assignedAt,
      'isUrgent': instance.isUrgent,
      'repairType': instance.repairType,
      'grade': instance.grade,
    };

PendingDeviceListApiResponse _$PendingDeviceListApiResponseFromJson(
        Map<String, dynamic> json) =>
    PendingDeviceListApiResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )..data = (json['data'] as List<dynamic>?)
        ?.map((e) => PendingDeviceDetailData.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$PendingDeviceListApiResponseToJson(
        PendingDeviceListApiResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'data': instance.data,
    };
