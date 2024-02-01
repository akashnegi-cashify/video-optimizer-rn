// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_lot_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingLotDetailResponse _$PendingLotDetailResponseFromJson(
        Map<String, dynamic> json) =>
    PendingLotDetailResponse(
      json['lid'] as int?,
      json['lotName'] as String?,
      json['deviceCount'] as int?,
      json['destination'] as String?,
      json['rm'] as String?,
      json['statusCode'] as int?,
      json['status'] as String?,
      json['cb'] as int?,
      json['cd'] as String?,
      (json['deviceDetailsList'] as List<dynamic>?)
          ?.map((e) =>
              PendingLotDeviceListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    );

Map<String, dynamic> _$PendingLotDetailResponseToJson(
        PendingLotDetailResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'lid': instance.lotId,
      'lotName': instance.lotName,
      'deviceCount': instance.deviceCount,
      'destination': instance.destinationFacility,
      'rm': instance.rmName,
      'statusCode': instance.statusCode,
      'status': instance.status,
      'cb': instance.createdByName,
      'cd': instance.createdDate,
      'deviceDetailsList': instance.deviceList,
    };

PendingLotDeviceListData _$PendingLotDeviceListDataFromJson(
        Map<String, dynamic> json) =>
    PendingLotDeviceListData(
      json['qr'] as String?,
      json['mo'] as String?,
      json['br'] as String?,
      json['im'] as String?,
      json['ab'] as String?,
      json['src'] as String?,
      json['aa'] as int?,
    );

Map<String, dynamic> _$PendingLotDeviceListDataToJson(
        PendingLotDeviceListData instance) =>
    <String, dynamic>{
      'qr': instance.qrCode,
      'mo': instance.model,
      'br': instance.brand,
      'im': instance.imeiNo,
      'ab': instance.createdBy,
      'src': instance.source,
      'aa': instance.createdDate,
    };
